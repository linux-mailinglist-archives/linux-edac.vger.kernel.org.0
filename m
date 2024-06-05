Return-Path: <linux-edac+bounces-1187-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D88FCE3F
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 15:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0C91F2B588
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDE91990C5;
	Wed,  5 Jun 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jJ/YStJc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E91990B3;
	Wed,  5 Jun 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590032; cv=none; b=urG2Y2ckdHw6ZwDkZmHyAqpSTPIKzEyX8OksoU7iZIkni2JWSe52R7A7lS7yRCEPavmRKpalmjlDwZ7zlaKFCkai2twXpNwEsV8Q8A7awadnwoEdqa9KB0vDESNsL2yeLU+rp6WwXZwEBh7zJSKW+fQIYj6srLugrfwgrlqBkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590032; c=relaxed/simple;
	bh=Isw1Rb90CkvWGeaWm1rp6CVK1Bn0jG3mFLlhRT69y30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq4xlZqHaZKqyPf4nU5wozW6pdUgoqCfwoUNlDhIuoMVqbme13TrdT1cRojFogNkxQRsz4FJOyI3TaGgXtAs/76b6+jP4vd6jlQezRt2nxN2cGszs+8Re2KvJ4n6v+88KiwLYHepOcBJ5qWM54JxCTyy/vWNL9S++XpAJ5PSHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jJ/YStJc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B9EC840E0177;
	Wed,  5 Jun 2024 12:20:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LbdEF1MBrpRI; Wed,  5 Jun 2024 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717590024; bh=yyocJ68fnCk370YMJK18X98QhZWFXJTCPUx5kM8HklQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJ/YStJc76C6zFmTFMLA7NntveyEybvDIt3XGcm7bqvijz+ErywHVoUsvCgBDkjul
	 rzgTSmcsFGgw13rTe8gSMW1pvz+vbB5uBE/9ytg4LUpETiwak8ngocQMr0pI0VoNhJ
	 DvIf5iuTv4Q28H8B9jqUhcxH0UerbdzHpu7aVfIql4PMaxAHC8caT8hqeTgblT4HRt
	 XMxbF56/YB6xk9JFGbJ075b8eevc+Jh5TTjLYOrOi/l8oFnhqgNVi2c/Sytm9NQeQk
	 YaeTiV7vGzbH/Hba9mwKTykLcoJ7DbW172DTQW9sGynijQcjXjwSNLNy8Xzi7eO3Hs
	 Y9jDeD99FxV8KoPygWXVL2j7TohNO2VihC1o8PQ3UacLARwQITcF5lDafHGLA7oruG
	 sWtyUXs6rZ3y03mtqvVhIb2ja+oEp4K0+gumxHITFyXckTWGH+yBRqOjhBzjN4pD3O
	 QIZmUolHQyE/Mdjs1afgslQb3qavhaygfBPPs+nEPY0+ZB/RuTdklOKwW4USjE68pJ
	 LU6tyLZIpZGGW30dpFid2IkSRvhnkvaln4Op8YK3lPJm+5qc5I4/WAiSIH28yJ4rqw
	 8M/0zL2X2ED9132mFgVpSGRxrm00wUNlrQgygnl3dc6qpl2adK972lYdtO4zMvGHo9
	 NpEW51iIvgai+J55TLPXz/BI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD2DB40E016A;
	Wed,  5 Jun 2024 12:20:17 +0000 (UTC)
Date: Wed, 5 Jun 2024 14:20:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 3/8] hwmon: (k10temp) Check return value of
 amd_smn_read()
Message-ID: <20240605122012.GXZmBX_KFQArXB9Lar@fat_crate.local>
References: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
 <20240523-fix-smn-bad-read-v3-3-aa44c622de39@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523-fix-smn-bad-read-v3-3-aa44c622de39@amd.com>

On Thu, May 23, 2024 at 01:26:54PM -0500, Yazen Ghannam wrote:
> Cc: stable@vger.kernel.org

So yeah, I'll drop the CC:stable tagging in all patches unless we're
talking about a concrete issue. You need to think about the downstream,
distro folks who need to go through gazillion of patches and wonder
whether they really need to backport them.

And I don't think misusing the stable process like that is the right
way.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

