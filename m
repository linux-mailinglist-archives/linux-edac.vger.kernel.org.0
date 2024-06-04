Return-Path: <linux-edac+bounces-1179-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC408FB0EE
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 13:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8391C211F4
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 11:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3C9144D37;
	Tue,  4 Jun 2024 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EQYWeJjL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148B1420D7;
	Tue,  4 Jun 2024 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499947; cv=none; b=pQ7OjiqsdNcgzhJDnHLbVoZ9HeO1DUKyKDup142a4KQhNhclzFC/SshekP3KMWPEgncRPj8MEA/ViUG2BEzUe0VdNq6EJ/JBNRKS1py3koP4CHEs6gAIJC3cq8HOkjHIiFx/zw0ag8iGu+x5T5DLXi4rMsuErDGcKA8DTu81GGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499947; c=relaxed/simple;
	bh=nAkg8d9ep+sPc3vDGdDGvhl6F1EDBybEekiuNHgyfWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMOhWBf1iU2PhNofMcF0K31RRPmpI7GJcz1p0ebudM6JX4VRhz/Dr2wDxigkpIPZP630lfnJIPfr934IyfPgTwF6rEkQK688ilskpqK0nw1K3fU3wbHq6Uxm008m3r/ji4l5y95qlrKZtb1c7hviYo3gyVVcdh1BKGau1Ddo6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EQYWeJjL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1A2A540E016E;
	Tue,  4 Jun 2024 11:19:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3aiBnw0VAp2i; Tue,  4 Jun 2024 11:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717499940; bh=XLfxJai+0mjiZ8+Z6/fP8Z5pWmdteCpMxgNQZVC4xlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQYWeJjLkAOk/HmALXC9NW3c5wvlN0M4x+3XJrxN9OPk+Rrinf7y5Krii8MOfxs/p
	 VjkqX8td2nbi8zmtQ/Xa/V/FgdXUz5YUsTSBJzQFd69/YRtdJnbNYoEJh6SJaAb/+L
	 SUpPFq6NHZOfZx6OqQyou9dTJYWYoZOILXESyJkXs8J0Pie0cOrj/Vd9ZgDXVnE99e
	 klszwimr4wtQM9Pqyeohq5z045WxOytHPiCbsyUlR49OFxvcFevMAOe70jSpRdKIZ2
	 SDvcUNsz+YdSzlvbU3XSQDxvcOzmoqIo9tHJ2FM9Y79BU34roEfqxInCHemUbppEzw
	 XfLyJ8DWeq2gOj/1rVOwcX1Lw3PDdFa6oWP+hvSz2z+DNjOWQD8odnwzDwhIxqr8Le
	 w7kpug/6UrbYSw9Gb/kCtY7GRUe2v2mUbsH1B2CzQLDCEyAw+y4ufU+t9lgatCWfIN
	 A7nUQWDmqm//tC1eqy7sdd2JzWRdHBxZkcG38zkUFfMALkkTZ49oWGYSG6kQpj8Wqc
	 ARiqgKNfizWd/iThGGgmgofFZIsSONMlpS7voQhqtWGx5ONFIP7yL2Yx5+UyQKoqqI
	 hrq5/T0n2JPzgx6QMfkq3MtQbCQP8cUF7K2ByNLrnYhT709+gIAQxEsR+REcIhVp4/
	 HgaSzZUktFVCWSHT69sGwZOU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6395140E016C;
	Tue,  4 Jun 2024 11:18:53 +0000 (UTC)
Date: Tue, 4 Jun 2024 13:18:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 7/9] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20240604111847.GSZl74F8Q6J4OTI-ev@fat_crate.local>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
 <20240523155641.2805411-8-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523155641.2805411-8-yazen.ghannam@amd.com>

On Thu, May 23, 2024 at 10:56:39AM -0500, Yazen Ghannam wrote:
> -/*
> - * We have three scenarios for checking for Deferred errors:
> - *
> - * 1) Non-SMCA systems check MCA_STATUS and log error if found.
> - * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
> - *    clear MCA_DESTAT.
> - * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
> - *    log it.
> - */

I don't like it when you're killing those written down rules. Are they
not true anymore?

Because smca_log_poll_error() still does exactly that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

