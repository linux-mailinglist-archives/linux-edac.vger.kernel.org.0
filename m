Return-Path: <linux-edac+bounces-2461-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C79E9BE6C1
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 13:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC566B25B23
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 12:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B441DF249;
	Wed,  6 Nov 2024 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FKu271qV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD71DE8B3;
	Wed,  6 Nov 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894740; cv=none; b=uQ2Mv4hA6FthTM1+EK0YsirwlN4scTzBvEZgRjo4g8JHrb/HQRQTqmNWk1S/+D8rHYdEOWI7iO9paIe7IQBraLM3zxcLU/F3g1uofv0ykB1fAeKF2xSSDjY19CFjfLYr4RsnLoqCrog0LubVsM3NyvxJXWQcIO7IhcrYaLFLwn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894740; c=relaxed/simple;
	bh=F6RW4rnN/Z3AhPOHTuhQGEWeVoHcE2U7ZTX3aHPNhdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtfMk3aqgcn9dFaEHrqR+DtK88K2Kh6maHvlJuVYmQcpxs2blo+MiJ8aRpSpT5GqQr05MqLKqxzqoHOcbpcjxHuiHAxOG5mM24EmYFgwbvQHGC511rtOO69AsNqlR9IJr6tqCXufIXwJYSV7DKfs9OjXX6u4N7g4fZMR4LyBNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FKu271qV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5DB5340E0169;
	Wed,  6 Nov 2024 12:05:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id G3oC6SuZ87vE; Wed,  6 Nov 2024 12:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730894731; bh=VG4ac25Kx3pagcdCdqNBXIAdGcPGywf/YeEuxIOFF+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKu271qVt7BkaBxik1OnzAMoq9FC72syfkx4Pu+A5dquS0DJvWaw+pU2k/Sdd38ye
	 i3acB6W5rQPnGMDQMdNKDH2kQqzWO2lqbIY9UYa5Rswq8HFzr46hySf/gRbUDeDyIY
	 rFBuqNslcPHpXl5pb+hruvYUoNYC5ZOvJmrIkAtRNBHhjY3JUBSFgKT+fBxXCo84My
	 F0VymXbxgMd5qPEQ75DOOjkBWEyCdWwh8ubBDphUu9zyICWyZUj496yqzG23Yf5ndk
	 31alEyHdKohDBh8Y3PzfICblH+zwErscIIiMFLBF3U6/N70WKFfIPayOopf+Tgp13z
	 XqL7el1bJXfeIVwxTWlcJOPc8INrX8wuZ9TgqaFWuGXo1lE5QfGHcfYmprTQWiEA4G
	 L8CjDMZsBBjjJGBc0vK6mn0ncOE2ygMj5zaRvRTQ8y+j2UE/EBGe2X0GTDZZm6Iaxo
	 LaqJEqgZhHraiNjrv8v1Twb245I+p5y6n2hL5tqdefVQcX+LZwDn939BNqXThBqwe6
	 0CfzFoH3otc8nFSmXlvs07SLua7KaDNavc1OGHGtbxFjti0ENV6drxbG258p/1rGCq
	 BdsbbA4ZHzIXyG2VuPqsu/B0+lj68E6PTKX3l0LGivabFtg7RJ53ofUx09tLmnvboS
	 fb12GYCmMcSuBl7CGS7vu8xw=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 71F1040E0263;
	Wed,  6 Nov 2024 12:05:22 +0000 (UTC)
Date: Wed, 6 Nov 2024 13:05:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Orange Kao <orange@aiven.io>
Cc: tony.luck@intel.com, qiuxu.zhuo@intel.com, james.morse@arm.com,
	orange@kaosy.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, mchehab@kernel.org, rric@kernel.org
Subject: Re: [PATCH 0/3] EDAC/igen6: Add polling support and allow setting
 edac_op_state
Message-ID: <20241106120517.GDZytbffKlnZxkSEsj@fat_crate.local>
References: <20241106114024.941659-1-orange@aiven.io>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106114024.941659-1-orange@aiven.io>

On Wed, Nov 06, 2024 at 11:35:44AM +0000, Orange Kao wrote:
> I would like to propose that we keep the edac_op_state as a module
> parameter. Because it would allow users (regardless of CPU SKU) to test
> different options on their machine without compiling their own

Are you talking about an actual use case where "users" really will do that
because there actually really is such a use case out there (If so, please do
tell because *no one* is setting that parameter and I'd prefer to remove it
everywhere in favor of automatic detection.)

or

are you talking about a potential,
it-would-be-good-to-but-I-don't-know-yet-whether-it-would-really-get-used
thing?

If latter, that third patch can remain out-of-tree until an actual use case
materializes and justifies it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

