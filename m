Return-Path: <linux-edac+bounces-5524-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC55AC80CA5
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 14:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEA964E51A9
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A14306484;
	Mon, 24 Nov 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SX03hVGl"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6B305E19;
	Mon, 24 Nov 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991303; cv=none; b=hY8gDB4lYELfIZ63ALhJt0Xmx8TRjw6Y5ETtaBJwEvdoykSGMqSgU7PdsjGwO7yldrjFQa/eAiWmANCJ+L75F/uP43HZi2c+T6+69wit3XAe2eWB+BliR2V90g+IAD+OxFT1qJ8nVyonX1TQMnKIv9JNcxbHZcR48CDhz3BsQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991303; c=relaxed/simple;
	bh=IwfrM2saSao4+BK4dW2CaO2F95xTEMgfAx7m+BEIE5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfP5P8fbSHKscewUCWm30jHrVrzOGBfof+tSLouiKCXb95Kj5l+WUWDJBkgFB2rXIsHWuSAnlrbJYAZdPl/3hWo+EYKNtdGiQXj+Wu9nh/SrWkrWDaomcXQE/fO+iJdnq+bUKogrfHuGVxyPiB0uJ7+w30tcL/map7fcHblx2AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SX03hVGl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3F00F40E0216;
	Mon, 24 Nov 2025 13:34:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ScYhU1G-4qtZ; Mon, 24 Nov 2025 13:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763991294; bh=nX+4lVgacGfDztgVc6fqiU1yU0+iTmtRhkTVZyLa0/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SX03hVGlyjyasg0YsBxosgyye1qk9jgUbXfl2Q7wRjiW85Z5KaWWuQs3b9pkqL7MH
	 FqDGHW24pS11ONCauqiQ9XF4HQSRvRMiIehcgr2NXfKzcDxbQWEN5/NRj4TnMs8r8R
	 wqu0vYObCnxKhibqhG9aW+iUoXIjGcJqXJyohGPZ5QeBKho32thdpC0aXkKwJ++uPH
	 IuuES8fWmq27PI2dIoYbTcS+Mrroo7K1vhAe3c3L01zj6z4U7l+7euuk0jbVU7cq2/
	 Zoct6Ag+yKSCWH2611ZA4yFyzzo6h8C1mD9/2GRlHGmYa54PIJzixigy2emjk18Tyj
	 w3Gt/g/wZlIPYhIbz9uLeA4Af1S0ntK9tqwvL2IHHsBy7iFFKCoecJric4yFbBmTcJ
	 H6hmo6CNuVuZ+DTXcwgLKUb5xjGjxzZkqAhNUzMUhpbZez9vQLJtg9SNpkL7XMpW3O
	 x2+2m9Xl/NbeJGcP9vLx+e1XKuFWsibuBy/S17FlDKQcolEc1aPdnQgjb2oDbV/BmW
	 O9GMhbDX0qdGkcLQD81xK1aUBd0aQ17OlMojTVHDx18ljWEb8SOCuv9gGaS+jqhWI3
	 1OYep51v6vrC7MAp8GNx0hJFi6KUbhDi+luFqWScjXizhhaFhnCuNPOmABSgfYYZwv
	 3ua4a3BNhrlREOFrM9XUgTsY=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D88CC40E015B;
	Mon, 24 Nov 2025 13:34:48 +0000 (UTC)
Date: Mon, 24 Nov 2025 14:34:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com
Subject: Re: [PATCH v2] RAS/AMD/ATL: Remove bitwise_xor_bits
Message-ID: <20251124133442.GEaSRe8jPj_7WBXAw_@fat_crate.local>
References: <20251124084011.1575166-1-nik.borisov@suse.com>
 <aSQeD-RSZxeuPj_h@google.com>
 <20251124110526.GAaSQ79mo0yx1h1Xxm@fat_crate.local>
 <aSRJdskInHGmbjIo@google.com>
 <20251124125249.GDaSRVIapy2dmis28p@fat_crate.local>
 <3e191e87-5b7f-49e9-b794-eb244d478c56@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e191e87-5b7f-49e9-b794-eb244d478c56@suse.com>

On Mon, Nov 24, 2025 at 03:24:40PM +0200, Nikolay Borisov wrote:
> So yeah, much better IMHO, unless there is some hidden latency in the popcnt...

Yap, exactly. And every CPU we care about supports POPCNT. And this is soo not
perf-sensitive so let's whack that function.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

