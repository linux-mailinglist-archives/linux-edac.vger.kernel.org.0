Return-Path: <linux-edac+bounces-2651-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7269E62B8
	for <lists+linux-edac@lfdr.de>; Fri,  6 Dec 2024 01:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3862813A0
	for <lists+linux-edac@lfdr.de>; Fri,  6 Dec 2024 00:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C2D1E51D;
	Fri,  6 Dec 2024 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="O/0Rdc5T"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0694F193;
	Fri,  6 Dec 2024 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446662; cv=none; b=jtBOwOO2ltpGWNZQDWkM9VyWt6hjlAEFdZfRAEIRqL1JeKmXScqU5fJrAL/1DNU8VkSlvhZLQuPKZXA11kgJL5C6onjNcsShjYoS9bZNdUI1WrbLmWtAPQ/fA0IB71/XeuIt/8LxvIoRP5IqqrLgBOkyUf/R9mgA1GZyGyTiBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446662; c=relaxed/simple;
	bh=kwOMnH+u5IAoSHvIY6bkC0ZWheAOiJb0SlAVXMM1Q0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFeaZ6MXy9oWCRp6As9kTt7iLEZbB2e/2nbrWouCCe2pQmDqbpsWUjr2nLIm7NPZ6Fmg+6suYkBGWsMX+m55OM/9gANSNtoNfRCrvthTn9p6BWwbDP0SJZpK1Wr2+UG2YOSeOzwZyL3DXs7Qd9x0lS+ZmLgAcUYyFk1/Nm7BMlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=O/0Rdc5T; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B60s4vr006020;
	Fri, 6 Dec 2024 00:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=LrUSZi7g/a8xkb8UWL38FyDn1g
	UQBK0tgVseIuMZxPU=; b=O/0Rdc5TaXrm/VGi29qXYAcgEslGan5QneGuRkD1FL
	17ZECQJt4AhV4JRQqXyB/SnEun2OofYHuYRokfrxPS9Y1QntmZf/QdFwCmxyaUmG
	rdXEjxfV/EdGzu13c3LPBWOIu6wOc3qT4InmnC6bN2YmbLl8jJh/JhWQAh9x25G8
	bINVea3pxpw0SsZoNTirFejYhqHYPE9qPyo4IxkSf39hMI/U5xLgP8kW48ZM99Us
	Cl8qTXrx7U979HcrBAgzqbXWAaZJCbK8PT7ybIBak23EVcWa0JPU3FS54SVO2cVB
	ftcEVufuwv+5rMqm/jeyV7uapiEbPMitGAI3XSz5nJfw==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 43bq4800rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 00:57:21 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 01F8227677;
	Fri,  6 Dec 2024 00:57:20 +0000 (UTC)
Received: from DESKTOP-V47QP3F. (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 3C8F480A244;
	Fri,  6 Dec 2024 00:57:19 +0000 (UTC)
Date: Thu, 5 Dec 2024 18:57:17 -0600
From: Kyle Meyer <kyle.meyer@hpe.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: bp@alien8.de, james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Message-ID: <Z1JL7fevweCQtTnT@hpe.com>
References: <20241205165954.7957-1-kyle.meyer@hpe.com>
 <Z1H7U9-O2LdAoa5r@agluck-desk3>
 <Z1IHkBlm_0p-0-c3@hpe.com>
 <Z1Iuk-_VdmZibOes@agluck-desk3>
 <Z1I-A0Rhc8AHhvtw@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1I-A0Rhc8AHhvtw@agluck-desk3>
X-Proofpoint-GUID: UQcTtQmVPiPioaFN6HTCjN8a9TKokAri
X-Proofpoint-ORIG-GUID: UQcTtQmVPiPioaFN6HTCjN8a9TKokAri
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060006

On Thu, Dec 05, 2024 at 03:57:55PM -0800, Luck, Tony wrote:
> > +int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
> > +{
> > +#ifdef CONFIG_NUMA
> > +	return skx_get_pkg_id(d, id);
> > +#else
> > +	u32 reg;
> > +
> > +	if (pci_read_config_dword(d->util_all, off, &reg)) {
> > +		skx_printk(KERN_ERR, "Failed to read src id\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	*id = GET_BITFIELD(reg, 12, 14);
> > +	return 0;
> > +#endif
> 
> Doh ... I alwasy forget about IS_ENABLED(). This can be written:
> 
> 
> int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
> {
> 	u32 reg;
> 
> 	if (IS_ENABLED(CONFIG_NUMA))
> 		return skx_get_pkg_id(d, id);
> 
> 	if (pci_read_config_dword(d->util_all, off, &reg)) {
> 		skx_printk(KERN_ERR, "Failed to read src id\n");
> 		return -ENODEV;
> 	}
> 
> 	*id = GET_BITFIELD(reg, 12, 14);
> 	return 0;
> }

Looks good.

> 1) Does this work? I tried on a non-clumpy system that is NUMA.

Yes, I just tested this on a Sapphire Rapids system with multiple UPI domains.

> 2) Is it better (assuming #fidef factored off into a .h file)?

IMO, yes, but there's one subtle difference. EDAC will not load on systems
that have a single UPI domain when CONFIG_NUMA is enabled but numa=off, because
pcibus_to_node() in skx_get_pkg_id() will return NUMA_NO_NODE (-1). Is that a
case that we need to worry about?

Thanks,
Kyle Meyer

