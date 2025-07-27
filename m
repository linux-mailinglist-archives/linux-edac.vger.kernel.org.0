Return-Path: <linux-edac+bounces-4451-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0ADB130DD
	for <lists+linux-edac@lfdr.de>; Sun, 27 Jul 2025 19:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9815C175B52
	for <lists+linux-edac@lfdr.de>; Sun, 27 Jul 2025 17:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880C921A420;
	Sun, 27 Jul 2025 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FSPJ5b1h"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32724A00;
	Sun, 27 Jul 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753636242; cv=none; b=ErVYQ04ogJOYKxC4bgY70bQ0KgiPBr01bcBUE9yGaRC4UKy6VyYrFgfYRr4TBWCvKcmP1taHNB+vIPT6/jkAbSBfODKr3ovtF0y3iDK6K1ON4GGZtDrfDVQHR00/pND93ab3qJwuE5gsOg9nvmmiR5q1CUxh3zAOaQyRIWBhQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753636242; c=relaxed/simple;
	bh=Zp23tZRvf8tS3BksPAvWD2DHYvAIYmrtNMJZW0Wr2hI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SDSsGZ+1z3BIsIWCD4ilJh9vZZPjm0WyIYmryvzMeGxEJGbEbB3+BCMmEG9Qtfqbfl+RPkX502v9nuWJyljNH7N1PTXeIdlgg2J7CPHt8CRhoPCXEXNRzO3XITTXTnP+mC0Lnueue81AOWOxqgMArSKS8N6q60FE8/mjmUBusUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FSPJ5b1h; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753636211; x=1754241011; i=markus.elfring@web.de;
	bh=tqsHsRfEurZWuxIUS0g2KGvPTie3Mdfsuf9vf3ZBUM0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FSPJ5b1hDwT+f9gqyghFWVO8tNBfkqPdXh/JjD/xcr9aQqoyA1Pt7aRpR26kMzlb
	 SBl5pV5LT2Z4sCPHP3BQUDjBwSsyJN+9JXxdiP6pMgtezstY5HfrGq9iVvDZEVrL9
	 Wq96Janjxbhnn1Cru8pWBeZqnitLbaB5AvHOJq4IS/+e3qzXcavOwSFasGJSKz9Vf
	 FibKHzD1WZJYGiWPTm7Z/RyRa9yqS4Kf34w05rxOsr/Mxmuiz0Q52apjtgVo/T94Y
	 upykMUTLPEyxuPnHPykj38VrAeERCCXPCJpBXe1FqfdetMlF6wsuj8Tnbe6dBoVk5
	 WpvanvQwXpWhEVeEIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjPQ6-1uHUld1fru-00de0X; Sun, 27
 Jul 2025 19:10:11 +0200
Message-ID: <d84ebaec-5c80-489e-a3be-79b0c3563e9b@web.de>
Date: Sun, 27 Jul 2025 19:10:09 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Salah Triki <salah.triki@gmail.com>, linux-edac@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dinh Nguyen <dinguyen@kernel.org>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>
References: <aIFqOz2bKFXIumM0@pc>
Subject: Re: [PATCH] EDAC: altera: Delete dma_free_coherent()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aIFqOz2bKFXIumM0@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9xEkGMDR6ywAyWd+Q7iN5mrYRTSThWm+z8vfo12lOemG2kw2A6U
 L4LnMfhG7XQVL9s9OOPtncTyrzYTmqPu04/fkY0NqiGjzqlS9JEgWyadm+//aMCC9+0wMJH
 TP/0RxdweBnWZOnBbibIzk6D/42lkmQjJQ1eR9jHZFi9b1V/5yv/M++gW0GEl7uGSlxK3++
 /y5ZD3zt2S7Ui1nBbk6xA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Fx3AVbD9uNc=;Yk99jXefmeavspxncjQgIwnOTgn
 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
 RSVhJ7uCD

> dma_free_coherent() need to be called only when dma_alloc_coherent()
> succeed.

  succeeded?

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc7#n145

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc7#n94


Would the summary phrase =E2=80=9CDelete an inappropriate dma_free_coheren=
t() call
in altr_sdr_mc_err_inject_write()=E2=80=9D be more appropriate?

Regards,
Markus

