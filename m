Return-Path: <linux-edac+bounces-1443-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D4E91E572
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56513B21700
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E43316D9C5;
	Mon,  1 Jul 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QU6Pr6i3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9914D2AC;
	Mon,  1 Jul 2024 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851730; cv=none; b=jvSazksv+rSyhTHNtphyK2+RlRccEeN/7pNW7f9xHLIxvJvVgfAFgF2Bbf9GYyVVsu7zvRMtIlypTOYKemSD+ItM5p9Hlf76gb+Z8x9sKVSqoYFNLE2eNFMEl9blHzBmkoFEW+8jI1u18JkvlJVkeDn9DgiUcbWhUsvn2rfkVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851730; c=relaxed/simple;
	bh=iJwna2UqPi//Js66lOh1R/Su9AKAXmxP+O/HRR60O/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNOAX71RngBDcG2aufVyuqTmE5hHOIX8hZhSRSts8wElUVGHUOVy5NRVn5vddZ2I+eju5VFnKF9ohYJgkUe+Rx34QA+2Nq3jseF7fCl9U/eJf3DM3U9ghCoE8otPbXOr1uIbGSrU4tlzXa6Q0IJEYIkywbYxe8nD45I2RsKA42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QU6Pr6i3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ECDEA40E021E;
	Mon,  1 Jul 2024 16:35:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 038GQN2N4R01; Mon,  1 Jul 2024 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719851717; bh=D/cjBd8ME02LHak1llm9Jgq5TdB+rOnTPPtzW3w1r/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QU6Pr6i37VTfqSO79Yb4/0qotz8YJ712H4I/6+fQMkqO7rlVe9G/uzVIQ835+AbnW
	 j2MTNG4fyWqgOfECo/EHWDUuUqlrpb5RNR/4pnDiIUNg1GhHC64VKBj9i4h9+KFV+m
	 Sd/j0pxUu2II2DpnqeaQQsbAw3Of3i31tORLsJ9kyqmDdrWZ+46QQebLWRsqJZdGqL
	 Vtz6W8LjimxLfap6mhe2X3Noj6n+gMDH6N7iRbyrO5lxU/MZd1V8eHpCe0/0zPO/Bm
	 unjWfqSnHFnDs9994RXKhlDPJHdIRUifbbV5tdRDS/OyhfRUITlEGshe1ej2xrGSnb
	 ByPv9McwW9E8uyaWi/xQK19XXJuSxXXt3ooZ86EivlnsmDbFiYS2Ii7QhKFFldiz8O
	 HGfJjTgNbH75JMz7Ubyfp4EEo3K89O44qje5ycKXnBxgWcvmqCzNigKuTbiAI+bEqd
	 915z73CUavNsUPqL5ME9oB5rXJqBDxvWw9LLH4S/mtMWTUGsEEzSzD5846PEdVpmk/
	 601SFeRuGxy09hcP5UKl9R6mOQVBvBHJT0ZTQO/MsbsEwErSfY2lfrysaUhJvOgVH3
	 cnXZZQjZzFl2WclAliBUVkokaFvcgiM+Y9vuOpY3vm/tf6D9tQa2e8qHpRV5hx7CkA
	 DteJrBgGYA6Fx3dEth4qznd0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 51FCB40E021B;
	Mon,  1 Jul 2024 16:35:10 +0000 (UTC)
Date: Mon, 1 Jul 2024 18:35:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, yazen.ghannam@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 2/2] RAS/AMD/ATL: Translate normalized to system
 physical addresses using PRM
Message-ID: <20240701163424.GHZoLakCmNflWa_Lzm@fat_crate.local>
References: <20240506174721.72018-1-john.allen@amd.com>
 <20240506174721.72018-3-john.allen@amd.com>
 <20240628074522.GDZn5qEkTXG0EvQ4Lv@fat_crate.local>
 <ZoLYCJVfoRLJbGtW@AUS-L1-JOHALLEN.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZoLYCJVfoRLJbGtW@AUS-L1-JOHALLEN.amd.com>

On Mon, Jul 01, 2024 at 11:23:36AM -0500, John Allen wrote:
> This is the param buffer struct used for norm -> X tranlations. I can
> shorten and clarify this along with the others you pointed out. Maybe
> "param_buffer_norm" instead and a comment explaining the purpose?

What's wrong with

struct param_buffer

simply?

It is obvious from the code that it is used in the normalized -> physical
address translation.

Btw, pls do me a favor and trim your replies like I just did.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

