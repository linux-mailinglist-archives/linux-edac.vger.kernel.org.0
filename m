Return-Path: <linux-edac+bounces-3528-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F35D0A873D6
	for <lists+linux-edac@lfdr.de>; Sun, 13 Apr 2025 22:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1007A6DC9
	for <lists+linux-edac@lfdr.de>; Sun, 13 Apr 2025 20:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E331E51E1;
	Sun, 13 Apr 2025 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Kqg8AlIs"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E3E131E49;
	Sun, 13 Apr 2025 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744576796; cv=none; b=mkmr4/YEdc9vsel9jDcmIfxixMkVsSZDgYvlk7Ay8XbCOgiqRWF0fh1MZfWaQ10dJzLeAVlAO1MPgEN/Mn8srFE4heHTyC/t+Fs2QzyTCu4cJ7qc2aPrKXzfm5KMEgVlOusez2FCkl0OAsyqy9jbCPhnvI6pe9GVMoa7jsl7RLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744576796; c=relaxed/simple;
	bh=Nw8QcptVhVAt+7InQoYP9i5Ze37D9ghFp28rjZFWcVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfE6LRcPzjGB7JQjT7wlRzmlsv5g2LiGpO3WW01Xx4zXNaIYIcz9R8jCjxttbIv2yCB9vcGBYYw8SKPZJ2DfekTfloySv9Lxkt8p5wo3Ue+y0YCNKqN2IqXXSZRPmw/9AUenILBnLh7HqkgteCDi4VyeN/kDHQRKOSpU/g3XyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Kqg8AlIs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9966140E023A;
	Sun, 13 Apr 2025 20:39:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z9Kj-hpq-4OT; Sun, 13 Apr 2025 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744576784; bh=gPLzKBqSBKNRAJiY7TN5psrgTIFFhLEvXzNfFCfBUvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kqg8AlIshxd5u9C8KBuy3Wp7l9B12d0HNDARJc+0gmNSYgSb/PwgK6IXnOAX1n4kW
	 lDZj46WnPEM60mVCk63IJLHHzyMoC2IUTb9Jc2GQ61OA1c/vbGkBktSNZqK8OLZefR
	 qwITABkf8pln7yanVWdLmnEor2t57I0v/D9vnM4+0wEJgEzbbTmR6hNjQWg976oId7
	 hsHsnve0kuFEvT3LU/l8gUwJ+Hc4R551cZj0NhES8qEzMGJaKk9ZNDDxkqBXRieZK5
	 L8NIKNtqs5gOetx3eiR04e8v11r6CiYJYCOzjqKnIGdv0zjEjOnGxWdlKZzZKoXQgl
	 Ye3K0Z08X19wVKThVBZkUl0SOJYsDk2y9ou+iqTx0/mDFg05rIpRYKnRjY8SBp36Io
	 2SyaolQSfjwiyGDNDp1qJW+nMcX65x55Ow9khk+0OdcPdw3mXMrH8eZTUb/sCGNVAl
	 AEJACqOCG+AJ4ZLEkE2ykOyFVZ/7PLySYd3pBxXxagIZ9zu1aaiQO3sGszANYnHfOr
	 IaolcUYqXGT7LO4cMEHeRaMT+vbh3LKyR9qy0dAlDvWl8PAx1JzPTZRPYZa6nIkOLO
	 wgKI+2BFLw7dZJEQ8lcC/IaOm+Ikm3ES2GYgQKsg6Ke/f7op+nFEXHzL2Bo26P/88i
	 39Ocw9tlCtxZa1kbQwArM+EM=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 572ED40E0214;
	Sun, 13 Apr 2025 20:39:29 +0000 (UTC)
Date: Sun, 13 Apr 2025 22:39:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [v7 PATCH 0/2] Add L1 and L2 error detection for A53, A57 and A72
Message-ID: <20250413203923.GAZ_wg-_lYFt5hkfbh@fat_crate.local>
References: <1744409319-24912-1-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1744409319-24912-1-git-send-email-vijayb@linux.microsoft.com>

On Fri, Apr 11, 2025 at 03:08:37PM -0700, Vijay Balakrishna wrote:
> Hello,
> 
> This is an attempt to revive [v5] series. I have attempted to address comments
> and suggestions from Marc Zyngier since [v5]. Additionally, I have extended
> support for A72 processors. Testing on a problematic A72 SoC has led to the
> detection of Correctable Errors (CEs). I am eager to hear your suggestions and
> feedback on this series.

Did you not read Marc's note:

https://lore.kernel.org/all/86a58kl51r.wl-maz@kernel.org/

or

https://lore.kernel.org/all/86frigkmtd.wl-maz@kernel.org/

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

