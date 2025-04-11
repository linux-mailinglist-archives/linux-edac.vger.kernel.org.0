Return-Path: <linux-edac+bounces-3520-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68796A86828
	for <lists+linux-edac@lfdr.de>; Fri, 11 Apr 2025 23:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D39174C9C
	for <lists+linux-edac@lfdr.de>; Fri, 11 Apr 2025 21:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC829C336;
	Fri, 11 Apr 2025 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JRqqtN4Q"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23E28FFE2;
	Fri, 11 Apr 2025 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406615; cv=none; b=QETy0fJz4Ip6QcdDj/NFX395RDcMC1VblcTyQAs9b0lhQkKW4Z3eU1SHH4UtmlJxBlORSEEWh6Fanxc8R5EXDdbOydFAnoEFriNzW7hdluwJs5oGqOoeepR1DjBl9CZKz+uVFL2QhSr0TTxh2QZek4O2nL25vRI/DqITvNUAGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406615; c=relaxed/simple;
	bh=d7CTNouMikVpNCKELbV8Zv1iC1VlzMsNvbBkIf56lMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of5E6LsuX1Vyr3nMQqWZ4myJaIHMFi9uCNWEyujYqZw0HwgqWLWhoqj0U00aYp7R5ZZGJOhOU1fwgEMXJ+XGoLRXoae75AylSKdaBTbF5EvMTd4uW8eSmDRjRRyqZXFa4fdZyMr+5824z3zl1R3BcUu4tFiKvKUo0D1ZZWV2Usg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JRqqtN4Q; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CB42C40E0242;
	Fri, 11 Apr 2025 21:23:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NDs9GDfPuPMf; Fri, 11 Apr 2025 21:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744406607; bh=d7CTNouMikVpNCKELbV8Zv1iC1VlzMsNvbBkIf56lMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JRqqtN4Q+QSnnGJl5Xoyy3Nuj45Y8lr/EznkeLeDqIXdVQlK9uMkIXikqhcBKxGkI
	 PpeseSKiVxSYZEDqxlegRRmn5eWeeFaHTYl1pTHUhE+IdjI2ghnRP6DcvGGfeL2mv3
	 Y6twcCEAGbr4Cb70sAMt73nJOrb8KQhBf43VDtBQroSdVCGGTmB4AN2I1cCefN1zMw
	 57HfY2+P3Yq/mgJvSMMm6eeb28ROCU7kjcMUmAlaAg2d2iGOhy6Cy8gEiyNsAlM+bh
	 LviMDsX1L5ynSEgt1hRGV0SUSMwcXlJcrd3W+HoEsp5pQqD9BsUgORT7bwMIbACeao
	 Wx0KU0K+XWv9pnbrVwCG5ZNeki5UZj6wdfcJIRS5Cr7YJEnOYp+Uf/focDQQYcJcdB
	 +rlwKqIhkDI9r+92vZFiIT1gn9x7Q9TyAIU+xip1mbY5HylGFVOQzJdT5N+E8ScbPn
	 FbSSZkOw/lTKeRcSa/3rREp4wwNJsc1xFcMtJ4uuX06UP1yiSjh+f5aXzmcUu6r3aV
	 EsCY6IxcXHPmcRfsLv9ekw4a/Mt8z8wDqWKigrTi5hz+EJ3dz3Iq9JvHSO+8JY/SlB
	 ilzn0Cni0C8uxbgrHf/AUt1eEdTExwaWOTbs9hZDy/lkRtZZkwLkeaAlF/lkA7+wEt
	 cyDu5VZJcpSgkJb3f8/GBF54=
Received: from rn.tnic (ip-185-104-138-50.ptr.icomera.net [185.104.138.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 06EAC40E01FF;
	Fri, 11 Apr 2025 21:23:17 +0000 (UTC)
Date: Fri, 11 Apr 2025 23:24:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sargun Dhillon <sargun@sargun.me>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] trace, RAS: Use __print_symbolic helper for entry
 severity for aer_events
Message-ID: <20250411212411.GAZ_mIexRpOrf-QKGB@renoirsky.local>
References: <20250317205516.599440-1-sargun@sargun.me>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317205516.599440-1-sargun@sargun.me>

On Mon, Mar 17, 2025 at 01:55:15PM -0700, Sargun Dhillon wrote:
> The chained ternary conditional operator in the perf event format for
> ras:aer_event was causing a misrepresentation of the severity of the event
> when used with "perf script".

It would be good to know why?

Thx.

