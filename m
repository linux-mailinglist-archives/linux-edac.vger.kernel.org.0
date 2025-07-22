Return-Path: <linux-edac+bounces-4408-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85836B0E21E
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 18:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9868B56637D
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 16:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9BB27AC2F;
	Tue, 22 Jul 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jymGO8/t"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378A25A34F;
	Tue, 22 Jul 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202865; cv=none; b=gn4JUSYlMkMtb9wggkZoqXKsq5sx064QUEJ7ogkiwp4Ux6lINis72BN6jRwSgaDU+XD3v6nHifRdG4Iz72WOE1433d2aMlW9D0IfTUNh3zJ6ksVC2s49LvVYkX7C4pUzCkZW0WtOT7GMrd14KGItWpB2lXpcAsut5xtsN8f/lUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202865; c=relaxed/simple;
	bh=rwAc0oq+8v45O1QJHR94JnMl109erpTHNRYkgJdzJgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGGkdttjT5sXKlnHF17eAJlIwzcoG9MTzMgs+v8DAv+ofdP2YPeWDJZ5gJ8roajc6RHxhgRUDW84q7Na5fO2+fD7Bm0Gcd7+Ttj16jMlRk3F52lp3QzE9MhrSQM4HZYa5qyJTjbfu3uF1OS9BCLmB0cXKb262bmxft1YNfCDrfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jymGO8/t; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2645E40E00CE;
	Tue, 22 Jul 2025 16:47:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FCv5m5ekeIus; Tue, 22 Jul 2025 16:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753202856; bh=yLIo3MPCbt0p2Q33/yHvmPVwnryqr2AZpgItxfxfUA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jymGO8/t7OohEs2KyyE9QM0o+Yb+a9vzpmPrZRmNWlfGxGcfND6WLhxzaHhmr8UL3
	 utb1/BOrMwIpc80d+GhBa3rLMwSjOX7Nd3xqiy+X1Z1EwkyP437gx4+Rp6VvYM0f1t
	 9wajTCB+5bH83mACfMcXPVTQGxF7JKsrkOMGKtBCY3corRO7U8eti8yUB411ieH9EY
	 tg4GqTROeraVJxCIcX2c07OGXtP4382XCKl63usTeKEfhad3ptyf4xVr87BKuadhpk
	 0fRU4z7o+21sWmyVecrd9DnoRjs1VGqTytfjYDhysGOMtQ8LtUkYauhAdxx5kWTCip
	 2ssvyT16tcp3PkPnpez81UZ8K8U9zrp5nxilQ63tvJe82y+WHSBGuagrOjyTTnyT//
	 oMfuVKPM/lQ/ZT213WYyrjhe2lilWGji2aUZNzHT5YfZIZ+1hnKRTf53wDZs6eVvm4
	 wgJX6vrpdNIwEkIhnYOqYbpWTtcbrJ3Df6b6YWurxtExB7qa8Q7AUyUqd39Yf+wT9G
	 hJ+yUL76b6FdeUA6VkJRSUyYTE96qCvHBfjvKZV57yQido74yH5lGg4cEhJ9dxASwb
	 GaceoXiM85QRSc2/DSipDHE5o6eKLirYyretayojx7lh4582mHQj4owUIq7w5bUH8F
	 67EXRGOju7LhahatEvcvjmUg=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8240D40E0269;
	Tue, 22 Jul 2025 16:47:22 +0000 (UTC)
Date: Tue, 22 Jul 2025 18:49:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rama devi Veggalam <rama.devi.veggalam@amd.com>
Cc: tony.luck@intel.com, michal.simek@amd.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, git@amd.com
Subject: Re: [PATCH v2 0/4] Add support for Versal Xilsem edac
Message-ID: <20250722164921.GBaH_BEb7bUJzf8Wjk@renoirsky.local>
References: <20250722160315.2979294-1-rama.devi.veggalam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722160315.2979294-1-rama.devi.veggalam@amd.com>

On Tue, Jul 22, 2025 at 09:33:11PM +0530, Rama devi Veggalam wrote:
> Add sysfs interface for Xilsem scan operations initialize, start,
> stop scan, error inject, read ECC, status and configuration values.
> Handle correctable and uncorrectable xilsem error events.

I had questions last time:

https://lore.kernel.org/all/20250422171737.GAaAfPMbFtNKN6paJT@renoirsky.local/

which went unanswered.

You shouldn't wonder if your submissions get ignored too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

