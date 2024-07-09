Return-Path: <linux-edac+bounces-1473-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A559F92BCD0
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 16:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F20E1F223F0
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 14:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370218C343;
	Tue,  9 Jul 2024 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cEaa5wx3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D619CCE1;
	Tue,  9 Jul 2024 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535096; cv=none; b=FXS6oMdD/soAizBH+0TWZgOoZHVX61NHHiyEbbWVIm8GDg5RrKuHPkYKhA0T7Yi21+YGqUqfpPvUvTQjuOnQ+W3yniHpMvASpzxrCriYdwRu+Dn5cy/Io+DXArgyjnOZ7r7ScRyDQf+F16x/erfEjZ52rRU9EiDFp22u1OMjeMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535096; c=relaxed/simple;
	bh=MTZEk95cVNmOlHjGboGqC2IjvsBNeV/FYtOh6Kkyrx4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WOGT21xxPTJ2cNVn88DtZbeQlYZG/VLsXYOjUadhi5RId7xbT+uTdwReqB/KCx8LATgzmENXu0s0SHAXnLkrZx01jWbOf7uEwEG02OdjszEaV2CWGxQkAhSIsZdvqUMcwGF1PUrNIaafzn8NR5UGai2qjDx3MkfqGV9usnJ7lTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cEaa5wx3; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720535051; x=1721139851; i=markus.elfring@web.de;
	bh=MTZEk95cVNmOlHjGboGqC2IjvsBNeV/FYtOh6Kkyrx4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cEaa5wx3voy8AQeo/RMUCaM0+M7rr44DeplLoH1LoL7zdkVRHn/MPpRnZEsT5M0e
	 NifKpB+EimH08fovMMrkbFy8JiZY/ANi2DOTfW0OgRKddWiIyET63L7n25uillPvw
	 2RiOQEMbe/QcARZxLV7qiEFJ1yPkHufrKUx3K/rKA2irvqh8X4xtNmC9J8ry/Hxx3
	 qB3j46b+Gr8okC4cErk0bQc7FcRTV87CkkVTIEZwQz6JSAEAOqWpUBexfJe0zipSP
	 zJf9NflpLF8U/DCaijwdW0SNpOnXsfS2cOZ5qMIVG3Gn3sC21MVRhr7paP04CFOzp
	 wxGzGs20bb4wIN5n0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McZnj-1roYDu32yL-00gymh; Tue, 09
 Jul 2024 16:24:11 +0200
Message-ID: <91a7a967-9aba-4e24-8e67-1b6d95f62d61@web.de>
Date: Tue, 9 Jul 2024 16:24:07 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, linux-edac@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dinh Nguyen <dinguyen@kernel.org>,
 James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
 Robert Richter <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Wei Liu <wei.liu@kernel.org>
References: <20240709133759.1012350-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] EDAC/altera: Fix possible null pointer dereference
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240709133759.1012350-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bRLtD/pS+yG61EgWsjRd99XE9ffwfsmXNL2IOhIGJOG7z8bScNJ
 JWtlU5evQSUiUZIYQhjrNm7kQ2j4W673J0oMWeGFt1EDAYI5ea+wZKfqykFAx/1OJkkXji4
 0IBJMRBP+2Yd/rayqT3VFjfiUrx/DYY6nyuBSQIdeoRZpxXn1S4vFEiRhzLA+0En71cmPYR
 i0C4Rd6j04i5yvfIGGEfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OUOKpLgiNhA=;iUBh/Goe++xlI5fnKz0aT+IvwF2
 dRzcAtz359CqFWr01azCrO4tHdx3x+7UbpNWJKrLjDDz07zUjDFURrHYDbd5D2DQn2fMV4XFJ
 dOGbwb/5dCDex+tdmwbzkVvaaCt/k2wBtr7Vy3aIALkSvLYqdRepJvv5S20tcyo/K5Px8zYUj
 ZHaUF1zI16PuU+7Ug25opRiOWZSkwtumaH2cZjmmKn0NpdfjwR3iP7yj4YUOU4sdzSVwMbvQY
 mqJi9h9M0qAzxjxlPBEC2ie9XfMgFsoRcxmAK5YdC2fTqNpfDk0OHz+r/8+jCvZw1HUmm9gY+
 tfB7R/FA8KmRmE9D6EA1+FJIdmafVTZgUP5E1bOjsDDxLcG3c2cEz4Yk5YInIOwfvtzxygrfv
 vx+SYzxbQ+YTButulnmddoLqeFh0+1OiVWTLnxl28PRgZ8KGI1bh5MhpVFz5kDINfolJE50tj
 QjmEgbUQCAzdrsaAXverXOFV7y5bPQ16eJRUQCApN+b/GPIsKZdMhyT5uYeRd2K8L2/llosVO
 QuuHGWHSlLYw5KL67WzQfeU2kGXxjibb65GwtPsAjeDG4bRiZBPnK4rif/yOTRlN3IuRkCNWa
 sRxeJmi5E9/IAZGhBVJ5tHzlOojk6u7TX98owU9nE1XwG2lOGeo3/TvvnuvavfUROnfiGw5eY
 q6dbatvxQBjsRg0b8beKiVf8ArCs9ydKlxu8AzaMjSgovdPNw7yk9BtCtxEg/NT1AN66vLy3s
 uEYC1GgwKUD/I+Itd3R6f3yx2owrt57L6e3Uq2YZ9T1/DmkMzM+ql5RZzRE4OH5mJBlwNJrcW
 cK0goW4T/n/aQGUGPMckuRm9qVn2vhbIQHOwfFQP2vAaw=

> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Under which circumstances will this information be corrected anyhow?

The usage of mailing list addresses is probably undesirable for
the Developer's Certificate of Origin, isn't it?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc7#n398

Regards,
Markus

