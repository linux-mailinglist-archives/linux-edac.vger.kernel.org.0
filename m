Return-Path: <linux-edac+bounces-1018-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E50E8C04F2
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2024 21:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE201F24709
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2024 19:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B43A130A51;
	Wed,  8 May 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fx6/uGoa"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4839AD6;
	Wed,  8 May 2024 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196403; cv=none; b=Vy2oDGxnc8G9xOw0bwoNXEenDhIimRXUWqGx2zv8p47/WkXEmwgtVopCadejdkcIRmmWhsxW9UXVuUiRgmuTYSW8zhgfP0fs05imOK3kKyJcnGIE0iyPlANBLuGwCkX+mcvf5NF60B1WYM+bDNqlt/faFPyLu0vGXYwNi22yE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196403; c=relaxed/simple;
	bh=AQ4aj6+Lyl30KBT589y0Wg9owBgdJw7PaStUeDorEOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIfZGCUBroqe8ggeWgXYQwzn5pVpGEdiM5cvBBi3Wa2juUQtQRBsjJ+0td8XZRg12LlpzCDowkE7Xfpuv48b1wxXeZOJRmu5x47quoh/BnwtEtLmXAKyeBbrWPcgPG1LNnd+KUFwbbNWbYiHYVGvLTefN932Pz7dZfiZf2gFCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fx6/uGoa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7D6BC40E0177;
	Wed,  8 May 2024 19:26:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FJBrvZdqr9td; Wed,  8 May 2024 19:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715196394; bh=MmARqp4eGq04zOmDOAjY3swGyB0SboUexwrUO+pYtb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fx6/uGoa2vQ7dKihmWFq8nD+Z7Wd+e9d/4odS4YYXLjbSee3L+gS6hSdpGMC4UQMu
	 aqCpPUpuCkFK2/uubhzOWl1CnYB4wCz2aeD8RgqUEfO16eWC0hWu9wSx7T48I7XSGt
	 nXesYrDt48iheoRGqCESLoUTOKf6BL8qh87w1ViWwttCPP+chEYhkc5U1L25f+7je7
	 n91teh1XUP8tuTlH+udSxGMS0QmC/nGr8vgXTAtJy0DNeG1y8kkev3ZS9s7IidWXGN
	 TW0Fk6Mj1el9/f049O5DwZmq1zEoz6yl7t49yocPaf0ilbbxqG+DuzCcFLDAwP3e4k
	 eLU/02AS8X76gLrPv+ZdqC6iDZsar/B9qWiiXwKO7B3wXaQVBGXa3GwZ69iAX/7wH6
	 tr+s75mn6L050ZWYGRnUjsENqEtqWK+VXifF15RP0na4dC00Z+aoxMFUpLavKBA7M9
	 b25V9A8dCTJhew6e60OiD2d+5QdVlZ+p/eS/2h58MArcaxAuTSd61UxkVC57O7NmtY
	 XxkQtXWTVnk3/0MCmsXDxu1khQM99af0zaHJQzAEOTNdjaXS1jVCez2s9/UPxlPdwD
	 DThHPSggIeJJY1FAddNQkYuDNe+Pwp2nXHB/fDs9rrESC7mNy6QZ/rE9xaTys4edad
	 d+KdXyZpBf72VCLFq0CV0IYE=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C481F40E01A3;
	Wed,  8 May 2024 19:25:51 +0000 (UTC)
Date: Wed, 8 May 2024 21:25:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-2-shiju.jose@huawei.com>
 <20240425101542.GAZiotThrq7bOE9Ieb@fat_crate.local>
 <63fdbe26b51f4b7c859bfb30287c8673@huawei.com>
 <20240506103014.GHZjixNhhFkgkMhDg_@fat_crate.local>
 <e0ce36eb80054440ab877ccee4e606de@huawei.com>
 <20240508172002.GGZju0QvNfjB7Xm6qL@fat_crate.local>
 <4ceb38897d854cc095fca1220d49a4d2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ceb38897d854cc095fca1220d49a4d2@huawei.com>

On Wed, May 08, 2024 at 05:44:03PM +0000, Shiju Jose wrote:
> I mean scrub subsystem module is not loaded and initialzed until
> a dependent  device module is loaded and a device does not get
> registered with the scrub subsystem on a machine which doesn't have
> the corresponding scrub features.

Stop this rambling blabla please. This should *not* happen:

# insmod ./memory_scrub.ko
# echo $?
0
# lsmod
Module                  Size  Used by
memory_scrub           12288  0

This is on a silly guest which has none of those dependent devices crap.

Your scrub module should load only on a machine which has the hardware
- not just for fun and on anything.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

