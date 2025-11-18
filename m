Return-Path: <linux-edac+bounces-5465-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CB1C6BAFA
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 22:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54F9B348CDE
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 21:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1482FFFAD;
	Tue, 18 Nov 2025 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fDBLX01+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9624124DFF9
	for <linux-edac@vger.kernel.org>; Tue, 18 Nov 2025 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500104; cv=none; b=YRr0q2TESSQlhp8T1cMzB57s7p32Bh9R6QC3vvlsDapES4Vv/11XSCX9xtMOmRjHcgH5pp1wMx2/PHIKUhhZyen0meBGLFrd5gYg0hNwHargZKC6I4fUAbeuz9U1bFqO2pvlquvL07LK9ZDQOfEDbnz66vLkfyyzgOS7+t2HJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500104; c=relaxed/simple;
	bh=XCiOAMTLAQC0wmH0nJftbS+Vq6WA2KIgOIj+dndfNWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpCOoEx+MRlPwDwoMVIEt/kgmAM2041LgTHnftvY6iQbiW0MHA0McXwGHYhIWYDWSkok1to2W2DDkL503NnbBdw6XBDk2Epxn7JFUwPXGHL/8Se7szmEhQ0mFQRZ2Ojn9tOOe+U/bgI8D8u4HcGx/jtE3fR3VjiT48YY7mFZefk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fDBLX01+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 342C940E0219;
	Tue, 18 Nov 2025 21:08:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UzLfZsYQRhkd; Tue, 18 Nov 2025 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763500093; bh=h/s3umMCXx8h73bysDCb3O6+/GyfQ9YkmgdtBcUkDOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDBLX01+73ukGxwb+JFEyBldEGtKCLm0ICiJ06KtoxJqK+4e7vNT3N0irYxlC6hgQ
	 m3syDq6/vw9OD8V5+qlEtbUTLLQscEYUtK+L5ysXWMybrQso4vS2fzVo8XQF/b8VH7
	 +Qw23LTZYzd5QvqOSY3FYirZLfexpRC057La+KCHX+ah/YiQgMyhjgdNofYw0jht21
	 iHEemSFxndtbW2vkT+txhVGoZSWBkb8SXmvYP5KFOsKyWqNURTqqeCsHF/VWSgiUNS
	 Mr0QwmDBloNkLWkrwWecOXJdsA7L5xolVPahFucrMiGcpOMeW+op0D7OYZvMKbJPzm
	 nRDj97EcfZTqXghCz1B3+TmEi/q0cgyxNKQ+Rl+D5sCm7LzBDxNnZNOpm8AMGN0QWc
	 v0FXt2lwmGNkXoLT69VK69sfdQgtIu6aEkaOoLIj427gFzrh8HCX/2nVUd/9GZXehT
	 aNgiyIpvT9JZGys8HmwZsG36yTb8KuOiYUOmomwhVA+0R4eUEJzmpVFzmaVc+On3Sc
	 LLWzAV2tiynt1/hH9oH6Gv6Cz27+I3F7pAy7/2/AtSNNjNQIk2/Oa635wDkn+N4piz
	 XZSwtPLqRL4ZMZ/au5cpRxCHY4yzuyCuj6YnQrK4K3hUC3XfGv1TOWYd9Lym7GCCX0
	 AX6IRxy6/7QC3skeBv8IJWcc=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id BBEB940E01CD;
	Tue, 18 Nov 2025 21:08:09 +0000 (UTC)
Date: Tue, 18 Nov 2025 22:08:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"shubhrajyoti.datta@amd.com" <shubhrajyoti.datta@amd.com>
Subject: Re: [PATCH v3] edac: versalnet: Use kasprintf() to simplify string
 allocation and fix error paths.
Message-ID: <20251118210802.GGaRzgMjsNtA8NXLPa@fat_crate.local>
References: <SA1PR11MB71307704AC76D92F04FC634489C9A@SA1PR11MB7130.namprd11.prod.outlook.com>
 <20251117110219.35852-2-ayaanmirzabaig85@gmail.com>
 <CY8PR11MB7134D2BE6FD3B07447A8425B89D6A@CY8PR11MB7134.namprd11.prod.outlook.com>
 <aRy-_vTTBL3jXbOq@ideapad>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRy-_vTTBL3jXbOq@ideapad>

On Wed, Nov 19, 2025 at 12:16:22AM +0530, Ayaan Mirza Baig wrote:
> Okay, thanks. I did overlook this, my bad. I apologize for these mistakes
> I keep making again and again. I'll make sure there are no more errors in
> v4.

Don't worry about the mistakes - if you make them, you learn the best this
way. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

