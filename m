Return-Path: <linux-edac+bounces-4550-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF3AB21264
	for <lists+linux-edac@lfdr.de>; Mon, 11 Aug 2025 18:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E263E6E47
	for <lists+linux-edac@lfdr.de>; Mon, 11 Aug 2025 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED292296BB2;
	Mon, 11 Aug 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="I7locnKZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37724888F
	for <linux-edac@vger.kernel.org>; Mon, 11 Aug 2025 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930021; cv=none; b=ezTBma8SnNJZCBSQpzPsqU8DnulPYrssc+BEmnKe9pOQcoUyq4lsvFa2cO3BkI/cE5Vag2nVPj/m6u6Y+nobSKNLHN6WY6m6NSuIFR7KRYatyO3Y8MWXHOwiYRE2bcRvyyAMD5uGNGpgyRFsd4PuOUHmTos322ocBedSJxl2BuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930021; c=relaxed/simple;
	bh=ymm3oP923cbaro/PxAHWtqG5LLpNIoSkHuv304fQLxQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XIF8yo8ltk5PFRFMxQ8hjctyOuNkllCsDlLF5L+Yy3BGdXC8brk95EKhaqE+kmWLhpP1HD0H7i1mis3EmS8B4meqAueIJKc+/cOaxHjWdyHrRaMkOGBqfp7NeER9pMKsXc1DqsgVXK907bbXWlMYF8IA9jx9vKXbSsOBIvBOtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io; spf=pass smtp.mailfrom=tuta.io; dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b=I7locnKZ; arc=none smtp.client-ip=185.205.69.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 7BF27B0E0FDD
	for <linux-edac@vger.kernel.org>; Mon, 11 Aug 2025 18:33:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754930011;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=5jWrnXN4VcbUsSjpG6KLH+gNLG1OTNZRhMF2RWICUsM=;
	b=I7locnKZYL87oRFlatSSTU6Hdut8B8IVY/zp03IiwW55mKORzyJXYOsvRtFIvqjw
	My+5TMp2jQlzBzy+nOLLQVU05YtTjM8N9TlPLXGhkg7Nn0/G3Nkf4yR2ZveNtpd99Of
	6rwMGxI1PHoGbAfZUpqZsRB9aQoEM59YQcV4OSsIdLgt13keNeCnSu7HA7tcby7Vna9
	5Eu6T/0LiXo7MERhxjkrF8jMd+9a3gyNghVvYj9Ut8qUxCJbL0gMRRV/9pKomzJGCqo
	NqRvMYHT4UmNPSPRzhRFSQc86QPDKPbz4L3vmP/XvILxmPIz5rktoM5Ziaips5h/bPP
	AvTOQ6Z/iw==
Date: Mon, 11 Aug 2025 18:33:31 +0200 (CEST)
From: howtobserve1@tuta.io
To: Kyle Manna <kyle@kylemanna.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Jernigan <jameswestonjernigan@gmail.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Yi1 Lai <yi1.lai@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <OXOyh9y--F-9@tuta.io>
In-Reply-To: <c2f98618-4197-41c3-9a2b-2c59841dd543@app.fastmail.com>
References: <20250802060112.363506-1-kyle@kylemanna.com> <c2f98618-4197-41c3-9a2b-2c59841dd543@app.fastmail.com>
Subject: Re: [PATCH v2] EDAC/ie31200: Add two more Intel Alder Lake-S SoCs
 for EDAC
 support
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi All,

Confirmation EDAC works on 8P+4E (DID 0x4668) configuration as well, using =
ECC DDR4 UDIMM sticks. Validated on i7 12700 and Kingston 2666MHz ECC RAM.

Raw logs:
~ > sudo dmesg | grep -i -e edac -e ecc -e ie31200 | grep -v systemd | grep=
 edac
[=C2=A0=C2=A0=C2=A0 7.834839] caller ie31200_init_one+0x1b5/0x480 [ie31200_=
edac] mapping multiple BARs
[=C2=A0=C2=A0=C2=A0 7.839585] EDAC MC0: Giving out device to module ie31200=
_edac controller IE31200: DEV 0000:00:00.0 (INTERRUPT)
[=C2=A0=C2=A0=C2=A0 7.843230] EDAC MC1: Giving out device to module ie31200=
_edac controller IE31200_1: DEV 0000:00:00.0 (INTERRUPT)

~ > grep . /sys/devices/system/edac/mc/mc*/*_count
/sys/devices/system/edac/mc/mc0/ce_count:0
/sys/devices/system/edac/mc/mc0/ce_noinfo_count:0
/sys/devices/system/edac/mc/mc0/ue_count:0
/sys/devices/system/edac/mc/mc0/ue_noinfo_count:0
/sys/devices/system/edac/mc/mc1/ce_count:0
/sys/devices/system/edac/mc/mc1/ce_noinfo_count:0
/sys/devices/system/edac/mc/mc1/ue_count:0
/sys/devices/system/edac/mc/mc1/ue_noinfo_count:0

~ > ras-mc-ctl --error-count
Label=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UE
mc#1csrow#1channel#0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0
mc#1csrow#0channel#0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0
mc#0csrow#0channel#0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0
mc#0csrow#1channel#0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0

~ > ras-mc-ctl --status
ras-mc-ctl: drivers are loaded.

~ > ras-mc-ctl --mainboard
ras-mc-ctl: mainboard: DFI Inc. model ADS310

~ > lscpu
Architecture:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86_64
=C2=A0 CPU op-mode(s):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 32-bit, 64-bit
=C2=A0 Address sizes:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 46 bits physical, 48 bits virtual
=C2=A0 Byte Order:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Little Endian
CPU(s):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20
=C2=A0 On-line CPU(s) list:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0-19
Vendor ID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GenuineIntel
=C2=A0 Model name:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12th Gen Intel(R) Core(TM) i7-12700
=C2=A0=C2=A0=C2=A0 CPU family:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6
=C2=A0=C2=A0=C2=A0 Model:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 151
=C2=A0=C2=A0=C2=A0 Thread(s) per core:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
=C2=A0=C2=A0=C2=A0 Core(s) per socket:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12
=C2=A0=C2=A0=C2=A0 Socket(s):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
=C2=A0=C2=A0=C2=A0 Stepping:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
=C2=A0=C2=A0=C2=A0 CPU(s) scaling MHz:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 22%
=C2=A0=C2=A0=C2=A0 CPU max MHz:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4900.0000
=C2=A0=C2=A0=C2=A0 CPU min MHz:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 800.0000
=C2=A0=C2=A0=C2=A0 BogoMIPS:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4225.00

Thanks
Aug 12, 2025, 00:19 by kyle@kylemanna.com:

> On Fri, Aug 1, 2025, at 23:01, Kyle Manna wrote:
>
>> Host Device IDs (DID0) correspond to:
>> * Intel Core i7-12700K
>> * Intel Core i5-12600K
>>
>> See documentation:
>> * 12th Generation Intel=C2=AE Core=E2=84=A2 Processors Datasheet
>>  * Volume 1 of 2, Doc. No.: 655258, Rev.: 011
>>  * https://edc.intel.com/output/DownloadPdfDocument?id=3D8297 (PDF)
>>
>> Signed-off-by: Kyle Manna <kyle@kylemanna.com>
>> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> ---
>> Changes in v2:
>> - Rebased on top of a6923c06a3b2e2c534ae28c53a7531e76cc95cfa
>> - Added comments to Device ID definitions as requested
>> - Added Reviewed-by tag from Qiuxu Zhuo
>>
>>  drivers/edac/ie31200_edac.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>
> Hi Tony, Jason,
>
> Gentle ping on this small EDAC/ie31200 change that adds two more Alder La=
ke-S device IDs for ECC-capable part.
>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>
> Could you please pick this up for the EDAC tree (ras edac-for-next)?
>
> Thanks,
> - Kyle
>


