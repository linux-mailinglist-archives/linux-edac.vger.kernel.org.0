Return-Path: <linux-edac+bounces-3366-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E902EA680D8
	for <lists+linux-edac@lfdr.de>; Wed, 19 Mar 2025 00:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAC9189CC88
	for <lists+linux-edac@lfdr.de>; Tue, 18 Mar 2025 23:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387922080FB;
	Tue, 18 Mar 2025 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OnwIaHzv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5C20765F;
	Tue, 18 Mar 2025 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341384; cv=none; b=tbGUV47QUhcxGQ72O/DiiGU+CD4peHpVO57vfD5sGXXXHIt6Kni73AME6n+tCqZULoQZmybRvlvjzamHxPJwv9l9gGLEfpB8C3XtaXdrzBj3kilZDZu7AsQppDJznLhcyB4hg8z7WQbdGds9Y/QSVzlmd3i8qbsI0PzKmNznHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341384; c=relaxed/simple;
	bh=6uF37CK1s6aWJmJk8x53KPY0SvFRKwF5//v/QN4xWjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZTd3bsoTZPyYoOe4dI+F0N4A/qItf0R60jKCen0xHkEWzZj47oDwBC608oj/KQNXVnazM+HEZsEEwGbTNONfdgDqvLPvOA6Kjq5Ow08PN2y3crsCU6zzPk1Rp77ywxZCrrF+di1MjYBUv9cb5FyTWm4eW+zGtf1NX+n/hzh0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OnwIaHzv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C7FD340E0215;
	Tue, 18 Mar 2025 23:42:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tq2t4CvvHE6y; Tue, 18 Mar 2025 23:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742341371; bh=irzXwATX6uB5clDSCObn3hi3OjaMA2OaN5lqOLbmIa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnwIaHzvS5YuspgO631ZY+PtR1cdnaptGzUzFRljJCKpUkR1BtF+FgmAjdM/VRZAQ
	 2GBUcvfX5BYmqGIJWm3ntkGvbEm/gpwY6UbdXbWDXLX7Stvsh5ki5xQdH9/6/7wa4q
	 te61EnRD/hd4tBZT2xLEDHdTujIDiOGfONI13fFneTXUiwE7DM6MsxmekW7tQVCQOk
	 69ShwG7+BwRQK7chT/bVs1nnRCraDJ4YTTTxGnIUQlmhzpsxQKVJ/N0Wm12rtHvtBp
	 xQ+WtQvEhuzLJ7ijRdqmUtXEyBqveXw3mTXykuCLNXO5tY2iBUK8AvCiLLQvvRoR/I
	 To46lr4o7aTH1g/RZd5/EGhYQxeaYQcclzgX7CeC6piQijXZ0d6h7xBIhIALtY9oRg
	 jA4KEPcFT/KIVu8c/hzfXmOvRfFSmZyvg+GGlK9HNTvo9zbKN1TEAnMzH8sgTqZyHj
	 kllpAZw86DVBcFKsYtHdagY/bkU946LhQWCA5D4XCI+OwEK+eLp7HPRY9FGgtFkLbp
	 mIpy8IZym6cLEfCM/WELdFfhrkBtwzK+L2lnkB2QCZvZErQHPIiwblzRaykRwKZoWa
	 XxFzH3+70dtP6ZNRF2htKhSBwwjEfyfVo5S5qnP5k2Gcxh6UsHvP0HtFF9ctytcSdL
	 4Vch8Lhm0dWOjtQfmwLmmFt0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1683340E0214;
	Tue, 18 Mar 2025 23:42:46 +0000 (UTC)
Date: Wed, 19 Mar 2025 00:42:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Thompson <davthompson@nvidia.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Shravan Ramani <shravankr@nvidia.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] EDAC, mellanox: Add ECC support for BlueField DDR4
Message-ID: <20250318234237.GHZ9oE7QOZG0nOjLub@fat_crate.local>
References: <046bf689-9a2b-4993-b8ca-927d7d2a0cc5@stanley.mountain>
 <20250303145226.GCZ8XCKkC0YSLHXycB@fat_crate.local>
 <PH7PR12MB590225F9E7C1BA48B5EF538AC7D12@PH7PR12MB5902.namprd12.prod.outlook.com>
 <20250311103106.GBZ9AQ6u6B8bd6W0Ul@fat_crate.local>
 <PH7PR12MB59028CE9CE0034598F539BC7C7DF2@PH7PR12MB5902.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR12MB59028CE9CE0034598F539BC7C7DF2@PH7PR12MB5902.namprd12.prod.outlook.com>

On Mon, Mar 17, 2025 at 09:34:05PM +0000, David Thompson wrote:
> Shravan's email is currently listed in MAINTAINERS for bluefield_edac.c
> My email address can be added there as well.  Shall I post a patch to do this?

Depends on you guys, whether you will maintain it and be responsive on patches.

Two people are fine too as long as the mails don't disappear into a black
hole.

> Ok, will do future work out of the "ras" repo, edac-for-next branch.

Thx.
 
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

