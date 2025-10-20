Return-Path: <linux-edac+bounces-5134-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF6DBF31D7
	for <lists+linux-edac@lfdr.de>; Mon, 20 Oct 2025 21:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C473B20D8
	for <lists+linux-edac@lfdr.de>; Mon, 20 Oct 2025 19:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5131D26CE02;
	Mon, 20 Oct 2025 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZsAmQNGj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E41E511;
	Mon, 20 Oct 2025 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987411; cv=none; b=rN9w9oMKJqcKN5GwtWWJ3VgTh2qNmb78WFUTf58+yx0DyoVoYVfGMyA6G07LJNKvZBdwzw7DG+mow+cHh9wFpyvvl00my3txXlcEA+BP6sbhRX3HF5DIWMjvqGc7WlbXVQto8ChdU61hF4bwIalt2dGr8oPQELLtd487qEupPx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987411; c=relaxed/simple;
	bh=utr8V9UeMjb6QISxUL2qxamL0ZBiCE2QUAJb85/Bd60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUT2fpmgKFD7oVVeUpX2pIqwbREEv386TbR/usCmpGf/GkIGPDKWTAlV/rrU41cXuPPzvTHXy/69c20MUMWhXazPy5Suqf7dymZFTh6xZ0TxlPoZx0Jin5ILFV3b8+VpRe7i1gejYGnuHM9C4nzY43QhOwUCMwM6YouEOhVEtAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZsAmQNGj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CA75E40E01FE;
	Mon, 20 Oct 2025 19:10:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ERTRKodTFuaE; Mon, 20 Oct 2025 19:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760987400; bh=bTGX0NEfVffiTG1Qm94t5E9c/C9xr2Sh10MSDBLKi/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsAmQNGjXGk1rPoNEyIW8gzo1eSzWUzfi7567q5zN8NqNOepBszYLYnVMLuvNbRxV
	 qropimKlK3bi/8rPNX8HDvNk6MP9a8N0cTtLOwn84yjWEXZgsSFANslhzb0Bokt9v5
	 pwb8JqD3uo5UeXBdd1TSfHhOEtYXdcUEL52/zJpIC6p06GFuGn4lcCO0OhWrz2Uqil
	 DK1ufxjXZgDOGolx8gHmZXDiE17VgdkWlX/mH7ZAVNrAh2F10QmNHUPcbDTb+r47UT
	 DlZs1oQtvU6m0VzcXBvrnjtO81Ah/4ICntPBElbFbH1UNYdEVltkM6AJW+wgDMK9ew
	 GiyTJImK2bzDxCkW3nF2EZAKvBWu/iiWe1P269DR5W3oswxrelU7Lfusnjy50bHIVt
	 CUYMY2jaagt6tujSl0tNVwynntN2elgzAUEkpK7AxprDUGVUS6q0UhpYquuqUB1WOY
	 7aQ8/hnrKJTCk/mb+2cW0zPEIfWj3mtfUPjTQ0UgHN1cu/XcANEV5dW/bnhnJtWvQW
	 W+c6+JJFcEmzgKl9v9kLY1AuKKETKBx7BMYefeok2NwnEBVyEdoPUGziBeuTMkYiIL
	 GvTqnv4WacNcbtR+ov98UzD0evB/IVyy5kLiP3KBPdQWnuZLaeJPL3WmQcqEWgUWX2
	 /PfvIbCZrQCAw61AIocb4m5s=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 82CBA40E01CD;
	Mon, 20 Oct 2025 19:09:55 +0000 (UTC)
Date: Mon, 20 Oct 2025 21:09:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org, Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 1/4] EDAC/amd64: Generate ctl_name string at runtime
Message-ID: <20251020190954.GDaPaJAlfg696iq_8T@fat_crate.local>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-2-avadhut.naik@amd.com>
 <20251020134756.GIaPY9jAoeEcBp95-k@fat_crate.local>
 <07a6d970-fda7-4f6f-8853-3e08392e63ec@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07a6d970-fda7-4f6f-8853-3e08392e63ec@amd.com>

On Mon, Oct 20, 2025 at 01:28:05PM -0500, Naik, Avadhut wrote:
> No reason as such. Will change it to 19.
> Do you have any other feedback on this set?

I'll let you know.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

