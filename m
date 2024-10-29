Return-Path: <linux-edac+bounces-2333-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE59B5330
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 21:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AEC1F23E66
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577552022F9;
	Tue, 29 Oct 2024 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f231kfJm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DABD1DB943;
	Tue, 29 Oct 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730232985; cv=none; b=Y7BVo0QVWDUdvv2J4vexD670o+Q0opex3BW+L6BfkZcmhmJpEB/q+9MW5NIGWQun9aijrAAN0A4WG47zy8KAkwHKj0+rhXIb5TtMerrTqsaVHAj4lwYHDKbFd9HuYpm9A5/F3pb126tI1jMepBTl01y0nt9MWOkRaBbmM5rdC5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730232985; c=relaxed/simple;
	bh=al/xwvq27s8QRhRPjGPRbgcotyOPaFKIbubTWs0tcNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMVv4Vug/AkSlpHs0mdzUk0uwo91AQTG+OkQSWpWSQgCdwUh98zec79SwGie1JDqppxPkBEYYgAF4OxHXg/OdLa9x/1CXDfgaumGvNcp7kMzrogmrgQE7Eaq1by1GCJ98QMTKQuRe2JlvIXLZg6qNx6EzHUXv+Ta8Xjuv7oWhFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f231kfJm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1EACB40E0191;
	Tue, 29 Oct 2024 20:16:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zmX8fzjVO5aN; Tue, 29 Oct 2024 20:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730232975; bh=C8woab/HVpTEdWSqbGbWHPK4TMUsahu9vIQAcQ2mkdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f231kfJmRUCtl4M1EDV4aVpEFrpi3fTbRG64EBB2rl90j3llW/hr7CAEEQwFXuAnA
	 nnVVhAJaQAA+NSiELcyoSUvRqbgYm+pU30Bn2MM4UDSVXJJojgWIuvs5654vAh3kin
	 qFCvq4Exs2nABJZ1+cFoFnbda+PqsTjWD7XVQ0toH2kaw9Fku9B/DxfslROIF5ryLd
	 jRTom6SwQgqLHELeKrpdjLGwYX4S0drdddoKpug2PvciAnsv1sZt32PEaW4eTrXfFf
	 clIfxIrf8h+XhE5OMendMIVelFpWRdJisbb9JlIzTPai2w4XaAmAYpud4HysbqlyuN
	 ahd/xqiCj7tfdG5p13ydXbB60XONM/EETz0/ErTTBKweHoC9pCRl61xpGU0+kzxqur
	 T4bcZk5zMivRCG+Nn73IG1+F1qVwpBDXrs7okbbotcX6UUd4xlktl6VhMyZ97eTX32
	 QnTzATB+Fm43ThOavpQCBII9tJ/M1A2c2od/Y+VeIcZIzkccyJiklPCgQ7mk2meGFH
	 ne1BPzkwR26r28i/ioYitcRMlWtxToSAvCCi+rXmaxK9aUvM/2dysp+dXMH5CrRsF8
	 YCj6y0JJB42uh1HbLDyvDdHJqydLPJ0twuRm5E1egJCzVNIsEppWJscUdOw/nqavWA
	 88BOcUSzKiMVWtRt/aaBiqsk=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7244040E0028;
	Tue, 29 Oct 2024 20:15:28 +0000 (UTC)
Date: Tue, 29 Oct 2024 21:15:27 +0100
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
Subject: Re: [PATCH v14 07/14] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Message-ID: <20241029201527.GTZyFCX_foMR_GouGN@fat_crate.local>
References: <20241025171356.1377-1-shiju.jose@huawei.com>
 <20241025171356.1377-8-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025171356.1377-8-shiju.jose@huawei.com>

On Fri, Oct 25, 2024 at 06:13:48PM +0100, shiju.jose@huawei.com wrote:
> diff --git a/Documentation/edac/edac-scrub.rst b/Documentation/edac/edac-scrub.rst
> new file mode 100644
> index 000000000000..4aad4974b208
> --- /dev/null
> +++ b/Documentation/edac/edac-scrub.rst
> @@ -0,0 +1,74 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================
> +EDAC Scrub control
> +===================
> +
> +Copyright (c) 2024 HiSilicon Limited.
> +
> +:Author:   Shiju Jose <shiju.jose@huawei.com>
> +:License:  The GNU Free Documentation License, Version 1.2
> +          (dual licensed under the GPL v2)
> +:Original Reviewers:
> +
> +- Written for: 6.13
> +- Updated for:
> +
> +Introduction
> +------------
> +The EDAC enhancement for RAS featurues exposes interfaces for controlling
> +the memory scrubbers in the system. The scrub device drivers in the
> +system register with the EDAC scrub. The driver exposes the
> +scrub controls to user in the sysfs.
> +
> +The File System
> +---------------
> +
> +The control attributes of the registered scrubber instance could be
> +accessed in the /sys/bus/edac/devices/<dev-name>/scrub*/
> +
> +sysfs
> +-----
> +
> +Sysfs files are documented in
> +`Documentation/ABI/testing/sysfs-edac-scrub-control`.
> +
> +Example
> +-------
> +
> +The usage takes the form shown in this example::
> +
> +1. CXL memory device patrol scrubber
> +1.1 device based
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/min_cycle_duration
> +3600
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/max_cycle_duration
> +918000
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> +43200
> +root@localhost:~# echo 54000 > /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> +54000
> +root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> +1
> +root@localhost:~# echo 0 > /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> +0
> +
> +1.2. region based
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/min_cycle_duration
> +3600
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/max_cycle_duration
> +918000
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
> +43200
> +root@localhost:~# echo 54000 > /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
> +54000
> +root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> +1
> +root@localhost:~# echo 0 > /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> +0

This file's addition belongs to some EDAC patch in the series, not here.

It could be a separate, last patch in the series too, once everything is
settled.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

