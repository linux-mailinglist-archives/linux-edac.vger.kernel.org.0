Return-Path: <linux-edac+bounces-2774-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B789A008D0
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 12:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0113A4707
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66171F8F11;
	Fri,  3 Jan 2025 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aAhBqa4i"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2FB1C9DF0;
	Fri,  3 Jan 2025 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735904577; cv=none; b=QNyABIfVKuFkABUkIzZorVFaaWQwK32cOrenaycNeP6/2073QlRudsqeoFp3DbigrVTV1xffOxI/2vEu4wJf0rE4pT0GJ1ByCkNjeCEwq1T7e/SFJGGroDawHe4ep9m5f62Q4OEXJ1CjQZE7Itxf1ztxXLkp2S7p3rf9xo3z9Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735904577; c=relaxed/simple;
	bh=Uv99LYTK0zUbacU0U6he7tjsya8rnMgHbBh+fS2b2jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itNAb4TSK+cUsUum3Iwyf4qzPxSVe94Wfrjbjkd1pcT6PuzV95hTIY82E/R31qyVU2qq8TnvmxDXtCc+ukoH2uuHdMfwep8O/a9SIyH8czsCS8W+1jjqO3tx1VI+xmnxl/OziQXQQ2rSjHlNOa75zIw2S2BUrAU0EeBvjHHFlow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aAhBqa4i; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 28BB840E021C;
	Fri,  3 Jan 2025 11:42:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tnfMMyzi7jTQ; Fri,  3 Jan 2025 11:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735904557; bh=dS9aeDbA2J+XdXLCPiJmDBE8ECZ7zdxygk6M6pb3jI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAhBqa4iddBtH6YyXT2qQ5M4szH55349aTo4zCkRpwy1ggI/dcZ8APuZSAfRLD7yS
	 Zf4JcLzQYkibsnDeUclDFD9g99GRvv+b2+vCf6ulJL58ykliLrgjGgJUXvBp+4VpIt
	 wvbg/tbGpMkWlCcn/sqSSbW8Ygn5DOkHjAhGD/hNyk0XC+mYq12e7OCljJUobTMVON
	 9G0rEZPQHFvUImHNC1EjJ9waZOokmzhW5GvC+r8mXC1LqpWWb4Ki5uGUz7QCZAMne3
	 ++5l0w+M3qJONf5e4qohmq43oOI+w6V9NMpWp9n8qgF5m1w3VXMEYFzvgNAJRaD97L
	 qYU7gCP/41vYeAGqayzNZzgofB5uxhU+/mVurlhIhBjEjb3tp5sKl31uaW9NAwqJyB
	 hKZRcvhAdOTPjyTaNARMbgFNDAYUTaS0jOuhVBJ/RxFFReeajXjenrFh3tBOVd4tTf
	 5Bnkw086E/0neelC0ykQXy2p8a8tChVp8LimHSpP++7S7J+w1DpiQNE4SC8aeAModH
	 7/Mkw8BoBGF8olQirsgkGge+BjDNoSwUKgwzsqV3p4q+AQQ5dU8dFSZPEha7+0OHli
	 vVkCTmGM47waNZerIHlaqHqtGE4KGknpNWksLnZuCnsaL2vTSIuMQTqRmVC6bqy5QX
	 ENIoQvgqd9+T4Elpu3Rsz98s=
Received: from zn.tnic (p200300Ea971F93bA329c23Fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93ba:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F123840E01C5;
	Fri,  3 Jan 2025 11:41:53 +0000 (UTC)
Date: Fri, 3 Jan 2025 12:41:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v17 00/18] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Message-ID: <20250103114109.GAZ3fM1dEsyBSn9lWA@fat_crate.local>
References: <20241122180416.1932-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122180416.1932-1-shiju.jose@huawei.com>

On Fri, Nov 22, 2024 at 06:03:57PM +0000, shiju.jose@huawei.com wrote:
>  drivers/edac/Makefile                         |    1 +
>  drivers/edac/ecs.c                            |  207 +++
>  drivers/edac/edac_device.c                    |  183 ++
>  drivers/edac/mem_repair.c                     |  492 +++++
>  drivers/edac/scrub.c                          |  209 +++
>  drivers/ras/Kconfig                           |   10 +
>  drivers/ras/Makefile                          |    1 +
>  drivers/ras/acpi_ras2.c                       |  385 ++++
>  include/acpi/ras2_acpi.h                      |   45 +
>  include/cxl/features.h                        |   48 +
>  include/cxl/mailbox.h                         |   45 +-
>  include/linux/edac.h                          |  238 +++
>  include/uapi/linux/cxl_mem.h                  |    3 +

So what's the plan here? Am I supposed to merge the EDAC/RAS bits through the
RAS tree and then give folks an immutable branch or how do we want to proceed
here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

