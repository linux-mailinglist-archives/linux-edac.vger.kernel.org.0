Return-Path: <linux-edac+bounces-2783-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC937A013F3
	for <lists+linux-edac@lfdr.de>; Sat,  4 Jan 2025 11:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81DB163BA9
	for <lists+linux-edac@lfdr.de>; Sat,  4 Jan 2025 10:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F16C1A8F80;
	Sat,  4 Jan 2025 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BKUWhmBy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65487193432;
	Sat,  4 Jan 2025 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735986684; cv=none; b=i1a+ju3DcSgtks2d8yk/eyVEH71LGtSWJGq8xsoYZvOpuR+Bm4cbkKPpTf0NXX16qljM2hImFLx75ycbtJamFw0yrfnts9ga7ioWJnnXb0Y3ZQUpAFCyDPyus7LOxHr2tMcTAcUdNZUT0nwzYWZexLApMmUq6jpUOIGybTsNCIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735986684; c=relaxed/simple;
	bh=RzTnsDOHi2iFWje3g8bJNXEKMPQ0+iW/+ANuzFE7bBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDPVAeY9TEqR3qftOJjQxUZtKbQ8vipKeUYfrdCsaozpXlFgrk+qsmDF6JUGmAE+0zeKlCxDReNwKJZ7nVKKJcUPT8J7O+6cLvSMJGvUW50yZBYoktPEY1z990cooxA8H/nyOQNNcJoRHSkWtqQ2BtG3LLfGhPSQO8MLqFk4NQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BKUWhmBy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E841D40E01F9;
	Sat,  4 Jan 2025 10:31:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id D00mqYbipsOk; Sat,  4 Jan 2025 10:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735986676; bh=MkI8oZQtdyShRyq/t7nRExvwEIHoVBW3vNVxPUWVDoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKUWhmByXcSS3i4uI1p4il/BYwBaPqGQ62tpDDTyH1cSLRkKI09PuV+07HR4ErP1J
	 cyjXkJ87/4hwOnChQUnGVX+ULOHPAqzPaYMwLudiPKciqqKgXSRW+PvLF0boqrnP93
	 VV9aRgzlkJ+5hD8vnQ/LiaGrnFhe4NEqOj6VKKLCif44FXtFcei69cXzn1BmSyIFwR
	 3cDfjnT+mO1cEDf9hfV5MX2TAUpjpwT0eW3uFllJ04SFWi8q1d28DmUhjoAIFOdU0Z
	 CB8fyLKMeeJ1QdRUQ5XTfRCSupRbCV1hf6go4lKq7/dX8QigQzg4xuNIfqMXENYJJ0
	 7qXmtNkMw9iKyNIPESALfMJi8q30dg/LBg0qvHDW7BBEJzdzhVrI9+YCa3N/FCMeZ+
	 NE/w4Sdan/UIh3vVCu9ap20Ye5+Pe/kBHv/+rouFPRE0ZCc8n9jzJbLMtLxXqE7J8h
	 zRd563PxSDDICV6kRkALah/lENp4xpk4vnjur6dIdyIlrTaVE/yQOT1kuZEBx99gtq
	 NOg1Pu8S7ocn4kVd6rBL/YqjdH9uigacqgM7+zxmim6Z6/XovKZltDyCC3gxsFHq0I
	 oJTISen5vMOJGY1lDW+XV1q4Z1GBFsKd6zD8pRCG2kYbYwAdh458YV50Qtt1sNDtgV
	 aEKeQCIEAQw4y7dPboqO6sks=
Received: from zn.tnic (p200300eA971f93Ba329C23FfFea6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93ba:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF2B540E0169;
	Sat,  4 Jan 2025 10:31:01 +0000 (UTC)
Date: Sat, 4 Jan 2025 11:31:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: chenhuacai@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@xen0n.name,
	tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, loongarch@lists.linux.dev, xry111@xry111.site,
	Markus.Elfring@web.de, Jonathan.Cameron@huawei.com,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V10 RESEND] EDAC: Add EDAC driver for loongson memory
 controller
Message-ID: <20250104103100.GBZ3kN5GP_EqgD_Urq@fat_crate.local>
References: <20241216013351.15432-1-zhaoqunqin@loongson.cn>
 <20241216115546.GHZ2AVQi9u5lABWboE@fat_crate.local>
 <2d4e5bd0-34dc-d781-3bd6-9eb7be2c1b17@loongson.cn>
 <20250103161942.GGZ3gOHmenp37jlyyd@fat_crate.local>
 <3194f91f-f20d-714a-20e0-3731df7029c1@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3194f91f-f20d-714a-20e0-3731df7029c1@loongson.cn>

On Sat, Jan 04, 2025 at 09:55:14AM +0800, Zhao Qunqin wrote:
> Let me review the patches for this driver.

Thanks.

> That ECC register can not be zeroed.

Pfff, that's some weird hardware you have there. Oh well. Lemme take a look at
your patch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

