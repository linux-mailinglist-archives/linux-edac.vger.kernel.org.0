Return-Path: <linux-edac+bounces-4690-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910EBB36C1C
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 16:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8201E585066
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 14:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E58335334D;
	Tue, 26 Aug 2025 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DEc4NFQq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00383568E5;
	Tue, 26 Aug 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218861; cv=none; b=rReJcKQ18WtqspFvJQFB4V8hTW7Q/Ei4Qe7WzcgIXIay/acm1JP8VqkDxqwfTJ7B8ezS5AP5Oe6CeejKtw/CF+ALFlYjUHosYPdj2nYQzTszZFIfES6o6cYy2XlPwK7HtZHsjTt0x8fydigXh193l9EIHkY5AtJhH7pio7/RVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218861; c=relaxed/simple;
	bh=1cX5uzwwWtT7IlBq+NtWTx0EM0OMVgd/ywTdFVCmtzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7uGyYnK/vHexE6YhHQSrCVkAuwo5OtPX5G8//xfuDLc26TebS1iA++5PxbtoQFq9h23gZDnqzqCTeanfEX7VE6VMSnvPT72TCE2+yo4qc9gNpYDbjMBJ+ly+Vf1qpOn1fOcuJjGHlOmjYlCZZnLbZ3RKBZjpD6W8H6czZ+xrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DEc4NFQq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 88D9B40E02A2;
	Tue, 26 Aug 2025 14:34:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QhlroA8LUIfL; Tue, 26 Aug 2025 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756218853; bh=F3if2Wo/v9m4Zzs32ixmbP2EUAvtd3ULQKDInuRJEc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEc4NFQq5Nfj4G+G3WbC8OU+sHxntp0jKE/XeIoZP70I8RfZYbGbaOeHj0l/KXFeP
	 XYZd27OOkzsh+9ciAlwFTlwcpj88T1A7qtRivzgPIS3B+ayYglk0LKLGkD/FOuHvWu
	 sTpzVRlz8h1Hf90Qjttl5YYaU3bCdYEs7mZMAyUZfXZHWhekInOkpLalUSOIINuD9o
	 YGNriyg8XFsVj+McnfJKWvpgk/fecw+4CiPOgGjqEmU3S6aX4JL8yFJTH8Q2lI9mIH
	 acQezzUCIvV+dPnAhvl7tq6rUB11YvIRtypcQcLcle9sg/AQWqFWN2OaMWSlncaVMv
	 czMh8oYJf1b+dy3vwIgTWc8EGZrAfXuJSjSeAmFJwGoQ5JTtHsBJgAQKkBKkoaDeK+
	 0IMX5ievRyIl71Zhf4br4UvU2Ahb8IjBdaKn+yBI4T9LDQY6R7MTokjOlGExfLIVFt
	 XHYTqDSJ7BYJJ8CWUVJqKErpTRRIxAI78fGyiyXHdgaClmTCktHz+YSk2AEZ/ZyfUw
	 1dC7m63bMX1Qrn1uFGMRxVpUoPToxC9Cn+MndG/iug3H99WbBm3tMtOzdMxgjmvKJe
	 eGyImIBNyyQ1N59bzAUjNflEvglClLjGGLXq2kQL9ATbooZwbAfHmauHb47GaZlSUt
	 pMyeoFnYOxMbmJMhFBWwyJ4A=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 217F240E0288;
	Tue, 26 Aug 2025 14:34:03 +0000 (UTC)
Date: Tue, 26 Aug 2025 16:33:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 05/20] x86/mce: Cleanup bank processing on init
Message-ID: <20250826143320.GAaK3FsOE2AjADWceY@fat_crate.local>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-5-865768a2eef8@amd.com>
 <20250826123503.GEaK2p9-e87SaTMKVv@fat_crate.local>
 <20250826134754.GA337914@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250826134754.GA337914@yaz-khff2.amd.com>

On Tue, Aug 26, 2025 at 09:47:54AM -0400, Yazen Ghannam wrote:
> But I see how any inclusion counts:
> "Any further SoBs (Signed-off-by:'s) following the author's SoB are from
> people handling and transporting the patch..."

Yeah, that's the important point: each patch's SOB must document the path it
took from the author to the upstream kernel. That's why people who forward it
by adding it to their set or whatever else, must add their SOB for documenting
that they handled it on its way. Basically.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

