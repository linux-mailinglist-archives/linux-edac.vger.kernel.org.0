Return-Path: <linux-edac+bounces-2653-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E399E6436
	for <lists+linux-edac@lfdr.de>; Fri,  6 Dec 2024 03:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565371689EE
	for <lists+linux-edac@lfdr.de>; Fri,  6 Dec 2024 02:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C136115B0F2;
	Fri,  6 Dec 2024 02:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="h0aqviOd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3654437A;
	Fri,  6 Dec 2024 02:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452432; cv=none; b=usmszxm//Xf2bGBDxhx5nRFm8c3wgIjbRGf9qykRRjC5EmQRum0hFqam97n3bHhW4CP0Ko8qCkCAJOEAh1vpJP5NO8rEXzIo2KygC+Zew3MCkFBfW/YeXcIn/DfEDL0m4KBkXWbTtrUib9HRYZSwrp0H76U/++0Xtc2oWMsIa6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452432; c=relaxed/simple;
	bh=Hu+PWZzOoEL7fHQA9oRdv7spRwnFA1WkCAuNxlSepA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOr2LcBcVCpqtDaKbE3miZoZMxlzpADkD75le+/syGMhtHNoCSIhT0OCYmRHDei1H8W+FUyXmsQ3Cpn7oqX8jwPr5RQsFTQy0X3HaWyof5X/2l6fYnkJ8B0VImg4G3ROXqiMrPArYIvJxETfWw5LK6gZrz9ZcScWF3ydXCk7G8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=h0aqviOd; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B61NORH007896;
	Fri, 6 Dec 2024 02:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=2ptQXIAoLbAo5fsJupX7l1C1pu
	lZTh/QjdikRsjALxs=; b=h0aqviOdw9lZiXRl0Y9u4Apk7ZGcsPWMcZZpoh5TYp
	+He3p9cXllL7cJx7hdbYPrt/bxzJ1lU53BTJCcjlhqHsCp4g1G9igwkelJfas8We
	CvDvB5D/3Ei8Ax2BfVuW6wdJt2P5l4FLWF65wtim+8sZg4wKmfC9gL6oG0Sy+0/q
	AjgdxekG50FvxA10bK06t8ytSQSGreBd4ryp/6TDHGkoYt8rIq6kZu3N30Hl1gTF
	qUNj96tHgNX7q/2bgpFt9RYGsJU45iXXvEAb2qhCzmimZJSliEkUvNOVPxo3jPfg
	spoBMlbGLfrgdjfDeOqligvcVQxRbh5mXrpoNNiIdg2Q==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 43bqja8gnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 02:33:34 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 59134804DC4;
	Fri,  6 Dec 2024 02:33:33 +0000 (UTC)
Received: from DESKTOP-V47QP3F. (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id BDE6C80B9B4;
	Fri,  6 Dec 2024 02:33:31 +0000 (UTC)
Date: Thu, 5 Dec 2024 20:33:30 -0600
From: Kyle Meyer <kyle.meyer@hpe.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Message-ID: <Z1Jieg7ACUMZLsF-@hpe.com>
References: <20241205165954.7957-1-kyle.meyer@hpe.com>
 <Z1H7U9-O2LdAoa5r@agluck-desk3>
 <Z1IHkBlm_0p-0-c3@hpe.com>
 <Z1Iuk-_VdmZibOes@agluck-desk3>
 <Z1I-A0Rhc8AHhvtw@agluck-desk3>
 <Z1JL7fevweCQtTnT@hpe.com>
 <CY8PR11MB7134E24098C6E16E43C57EAA89312@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134E24098C6E16E43C57EAA89312@CY8PR11MB7134.namprd11.prod.outlook.com>
X-Proofpoint-GUID: 4P8DZEfPJvGZxqk-olS1XhYRUD0G7Qgl
X-Proofpoint-ORIG-GUID: 4P8DZEfPJvGZxqk-olS1XhYRUD0G7Qgl
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1011 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060017

On Fri, Dec 06, 2024 at 01:26:12AM +0000, Zhuo, Qiuxu wrote:
> > From: Kyle Meyer <kyle.meyer@hpe.com>
> > Sent: Friday, December 6, 2024 8:57 AM
> > To: Luck, Tony <tony.luck@intel.com>
> > Cc: bp@alien8.de; james.morse@arm.com; mchehab@kernel.org;
> > rric@kernel.org; linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple
> > clumps
> > 
> > On Thu, Dec 05, 2024 at 03:57:55PM -0800, Luck, Tony wrote:
> > > > +int skx_get_src_id(struct skx_dev *d, int off, u8 *id) { #ifdef
> > > > +CONFIG_NUMA
> > > > +	return skx_get_pkg_id(d, id);
> > > > +#else
> > > > +	u32 reg;
> > > > +
> > > > +	if (pci_read_config_dword(d->util_all, off, &reg)) {
> > > > +		skx_printk(KERN_ERR, "Failed to read src id\n");
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > > +	*id = GET_BITFIELD(reg, 12, 14);
> > > > +	return 0;
> > > > +#endif
> > >
> > > Doh ... I alwasy forget about IS_ENABLED(). This can be written:
> > >
> > >
> > > int skx_get_src_id(struct skx_dev *d, int off, u8 *id) {
> > > 	u32 reg;
> > >
> > > 	if (IS_ENABLED(CONFIG_NUMA))
> > > 		return skx_get_pkg_id(d, id);
> > >
> > > 	if (pci_read_config_dword(d->util_all, off, &reg)) {
> > > 		skx_printk(KERN_ERR, "Failed to read src id\n");
> > > 		return -ENODEV;
> > > 	}
> > >
> > > 	*id = GET_BITFIELD(reg, 12, 14);
> > > 	return 0;
> > > }
> > 
> > Looks good.
> > 
> > > 1) Does this work? I tried on a non-clumpy system that is NUMA.
> > 
> > Yes, I just tested this on a Sapphire Rapids system with multiple UPI domains.
> > 
> > > 2) Is it better (assuming #fidef factored off into a .h file)?
> > 
> > IMO, yes, but there's one subtle difference. EDAC will not load on systems that
> > have a single UPI domain when CONFIG_NUMA is enabled but numa=off,
> > because
> > pcibus_to_node() in skx_get_pkg_id() will return NUMA_NO_NODE (-1). Is
> > that a case that we need to worry about?
> 
> I think we need to make the EDAC load/work even in this case. 
> Regardless of CONFIG_NUMA or whether numa=off is set or not, could we do it like this:
> 
> int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
> {
>         u32 reg;
> 
>         if (!skx_get_pkg_id(d, id))
>                 return 0;
> 
>         if (pci_read_config_dword(d->util_all, off, &reg)) {
>                 skx_printk(KERN_ERR, "Failed to read src id\n");
>                 return -ENODEV;
>         }
> 
>         *id = GET_BITFIELD(reg, 12, 14);
>         return 0;
> }

So, we're back to the original issue on systems with multiple UPI/QPI domains
when NUMA is disabled.

Systems with multiple UPI/QPI domains can't use source IDs to map devices
to sockets. skx_get_src_id() will successfully read the source ID from PCI
configuration space registers but it might not map to the correct socket because
each UPI/QPI domain has identical repeating source IDs.

For example, 8 sockets with 2 UPI/QPI domains:

Socket 0 -> Source ID 0
Socket 1 -> Source ID 1
Socket 2 -> Source ID 2
Socket 3 -> Source ID 3
Socket 4 -> Source ID 0
Socket 5 -> Source ID 1
Socket 6 -> Source ID 2
Socket 7 -> Source ID 3

EDAC will successfully load, but it will not find the the corresponding device
for errors on sockets 4 though 7 (for example, see skx_common.c:178).

Looking at my original patch, EDAC will not load when a system has multiple UPI/
QPI domains and NUMA is disabled. We fail early with "Failed to get package ID
from NUMA information" instead of later when an error occurs.

Thanks,
Kyle Meyer

