Return-Path: <linux-edac+bounces-4811-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7FB591CA
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 11:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E1318968F6
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347C0285C9E;
	Tue, 16 Sep 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iz/MheB0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346E42A96;
	Tue, 16 Sep 2025 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013884; cv=none; b=YWsVw0wQ7VZSJPC25LyVdOQBZRgzJ3VIdQcfWb6u7q7sfGt8YL4l3GY4zQSJnoU+xVZowX2Dszsq/M4YNTWeeDEpztTI1KTAwlbENFNVE9KJejIkH1FF4mSVvshTBJ1meCQFcFCt0S7XHN8HIGT8qMY0tZFxxCBw1hSQObH0MzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013884; c=relaxed/simple;
	bh=KkPyIIbyd5SJjuqod3wdkU2p2Zh9ZN9dF3Jz2Jnh14w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8DHlipMiDFscAi/24gnf8YCdcw+Yxl9upZ5uEvIqwMy6WzwHYwKIubcTiSKG4ZQnx1RQEAHGX9Rf/6oVwENXs0idvyBszbzXiiKQWQ2XEhwAO+TGfH0xrKXtrqL+kB48GdsujsbVmGwTGB3cr9cc+8ODBlWpq3Y+SPu4A37zmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iz/MheB0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0C2B140E01A2;
	Tue, 16 Sep 2025 09:11:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zIaqC3HLNQ9L; Tue, 16 Sep 2025 09:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758013875; bh=QWJBpCxYGdhhSeLXQ8ldzOPuqWrT3lCtih2UBg+SiEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iz/MheB0csedEfyBEa+OtYeLXTZ7jC4FHJuGUmtU2JErkakOF7ixRTLPrEoJS+p/n
	 xTlQ8aKSJq7KILBNxkqFBq8NJji1w1/bFT3QxymiSf0elE/d66qF8lIygWpkqGlGvo
	 OXlmKiWVSJCT6l0hJ8UwOumlj5sJswW4bR02xwc7fs8vyrEJ1ioKP/UskPkkHvAYM9
	 wW1iKwLy/SlpKT3iOxOEqfha92efzeXPlv4NnX/ynB0ch71JmNtwckRNtdmxwungLY
	 jmIVmFxGjjHaDf6At9Gtjpc45liuNSGHi5o75oceefknuZ592q0OMyT1kj9R8usDBz
	 8UPs36thYuH+e8CP9rrfalwM16vO8keyJEOEpX5B6k98qVPyTdqBgOJw2H9tIT5WW5
	 9rOZ7By/GZGzjSTQkzH8ld8rpM0OMBjaqpnLEV7OBy19C2hZODmVegHAtu90uTy7Ad
	 Q+YT0r8ro74zafqKQO0DS5hN29j8NFBorZK3wM3RLbJlqItYa0ttNTohhlF3lkMPG2
	 kgO1ipRIuo3Q3eLxrHANpYo+1dDPtMMgu63DLTNwNFuxKa7NljXqKYpK/wr7SMtfOk
	 Fil5HoP1/jLI+FH/gfJatDlhp1aib5eSb/++iP649C7fDzcq98fj0ke2Y5iFA7YLLn
	 F5aP2LL/SJTR+erhbN7NZom8=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5589940E01AC;
	Tue, 16 Sep 2025 09:11:03 +0000 (UTC)
Date: Tue, 16 Sep 2025 11:10:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Bert Karwatzki <spasswolf@web.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, x86@kernel.org, rafael@kernel.org,
	qiuxu.zhuo@intel.com, nik.borisov@suse.com,
	Smita.KoralahalliChannabasappa@amd.com
Subject: Re: spurious mce Hardware Error messages in next-20250912
Message-ID: <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
References: <20250915010010.3547-1-spasswolf@web.de>
 <20250915175531.GB869676@yaz-khff2.amd.com>
 <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
 <426097525d5f9e88a3f7e96ce93f24ca27459f90.camel@web.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <426097525d5f9e88a3f7e96ce93f24ca27459f90.camel@web.de>

On Mon, Sep 15, 2025 at 11:43:26PM +0200, Bert Karwatzki wrote:
> After re-cloning linux-next I tested next-20250911 and I get no mce error messages
> even if I set the check_interval to 10.

Yazen, I've zapped everything from the handler unification onwards:

28e82d6f03b0 x86/mce: Save and use APEI corrected threshold limit
c8f4cea38959 x86/mce: Handle AMD threshold interrupt storms
5a92e88ffc49 x86/mce/amd: Define threshold restart function for banks
922300abd79d x86/mce/amd: Remove redundant reset_block()
9b92e18973ce x86/mce/amd: Support SMCA corrected error interrupt
fe02d3d00b06 x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA systems
cf6f155e848b x86/mce: Unify AMD DFR handler with MCA Polling
53b3be0e79ef x86/mce: Unify AMD THR handler with MCA Polling

until this is properly sorted out, now this close to the merge window.

Thanks, Bert, for reporting!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

