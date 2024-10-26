Return-Path: <linux-edac+bounces-2311-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B329B171F
	for <lists+linux-edac@lfdr.de>; Sat, 26 Oct 2024 12:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC150283B17
	for <lists+linux-edac@lfdr.de>; Sat, 26 Oct 2024 10:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617541D27A6;
	Sat, 26 Oct 2024 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="N1VizaKd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6891D0E23;
	Sat, 26 Oct 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729938991; cv=none; b=nc8HKdQ30hapLoWu93vc+xEC7b7wSGn9upyzSbdlC0bTVDU8cZCPdPaKqAs5kmgcrsnz/Eyiyx+UT4Ny03JK3zwlipoga5qJtbVGKf1GkQa9ttqfT9fdb8VOiyNSXTmLBvAv50OkpxkA47KZyi3SI7Ke+d/+Mx7Uy9I6DawIBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729938991; c=relaxed/simple;
	bh=xOP0RBv4LcWrWdWWJIfZyUUrJbDEehyxMDYxK5HToBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fP5wMNNZ0KJVMcNoTPd5c34N3+AYkIFtm6Al9MVlg2nDDf2ahXwgruWQDqM35tgRkAUpcUIfWEmprZ2iHa1cl6i/we9CFdMzmu5AFLWIIHGPaf4BRfRze0wLxc3iVq9TALgicX/wfY50jVfbWt1/IJoWttPOc0XuUns5zxpLLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=N1VizaKd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BE51340E0194;
	Sat, 26 Oct 2024 10:36:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QsfRxQkhLaRv; Sat, 26 Oct 2024 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729938977; bh=m/UJBUXYW5lVSHFFedycWJpRrNGkg0U0rad07TvvJbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1VizaKdFhUz3gwTEK7lK3NCHkqosJduyF+R7fA9e6SgYIwCc4tp4mTAFQgCTwiYL
	 FwgK/KCxgGmslBO+xlp/TPJel8Yac91DuH/pV8yymJ01fzLU9g6q6ImJIrv1TNT7Cm
	 YRFrJEFyMhT1ju4MGgOQ/x3Jqz8yyFlP+jzgpNQIe/k4NIDHgPOmb3ekEk5yvyV43a
	 xIrMHIHzkwTkWjEniZC987r647fUG65bPyKN6f2gga6aLgaqMoeXbYs60SaNYVXNj0
	 Xi5NyubgRpTvvN5H2WBpLShcXVD2iNRW7nPVBeTLuTasWA5Xc2tivajIz8VY6OM1j5
	 Yo9kiZXs2Xcs93kqzKx27PMDYeT3IlWe/Q52NXJPl0qeF+G40Buh0S+NT7IWNSaZ7z
	 UAW6Kd8810gmdtjNuZQwYLG1nNKva735A8O/wJxzHtV4KbnmrpcUO4nN7rfMEocDJE
	 UYVVkNnyJcicddF2dJgbyaWbByowNHRH5ayMCLKiXWQAep7PJJAkjkLDLvn1k+/RXR
	 TOFPGr3pQ4HCiumRUkD5817MdbHqZ0opu/ROUl9CU5xUABFhfGKP9krHlO4SrG4d49
	 LGsjlC20OVs5X1Azc/jxEkNvusZnhiZB6XHvgXbf7BLw2i1y3usFTJI3ZI7wxM/Ic/
	 3ZbXGnPu/MS1nqs/fe3uroFU=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2DC0F40E0169;
	Sat, 26 Oct 2024 10:35:31 +0000 (UTC)
Date: Sat, 26 Oct 2024 12:35:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, gregkh@linuxfoundation.org,
	sudeep.holla@arm.com, jassisinghbrar@gmail.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, david@redhat.com,
	Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [PATCH v14 00/14] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Message-ID: <20241026103525.GRZxzF7c-n1jUi7byt@fat_crate.local>
References: <20241025171356.1377-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025171356.1377-1-shiju.jose@huawei.com>

On Fri, Oct 25, 2024 at 06:13:41PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Previously known as "ras: scrub: introduce subsystem + CXL/ACPI-RAS2 drivers".
> 
> Augmenting EDAC for controlling RAS features
> ============================================
> The proposed expansion of EDAC for controlling RAS features and
> exposing features control attributes to userspace in sysfs.
> Some Examples:
>  - Scrub control
>  - Error Check Scrub (ECS) control
>  - ACPI RAS2 features
>  - Post Package Repair (PPR) control
>  - Memory Sparing Repair control etc.

The non-patchset handling information, i.e., the documentation of the feature
and those nice graphics in this 0th mail should go into 

Documentation/edac/scrub.rst

(yeah, no "edac-" prefix to the filename) for future reference.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

