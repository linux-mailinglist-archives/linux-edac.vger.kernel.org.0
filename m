Return-Path: <linux-edac+bounces-1771-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6D59693BB
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 08:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3AA1C22E66
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727E11D54FD;
	Tue,  3 Sep 2024 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="i4Lt/3da"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6441D54D2;
	Tue,  3 Sep 2024 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345226; cv=none; b=EW70vryCAUGiGAWu8ZpZUDjPXam5rmN8N5BELLn2Iy20i5irgX6rpzFq6QoJ8QZaPqVGsNfHy7B1C6EIKUoJztYXS3WW3rDos9FBSp4vtjHFOEmfAPGFY2sQ5V0dbfElU9U7EPjbL/7bkqkchcPHiMaiwPcPYblDe8a8CXrN/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345226; c=relaxed/simple;
	bh=0X5JD1dKXlRjMro9PE7Xoxlt20rlpE2CIb0nggH/kC4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=fr1CmuzXibTWrZhpoecRh7l8wG65G9oY0TZM3uQwdINBpQE0xYMY2TuOKVGBGu1Vt041vEDFu7kW15ut68zAk7JCDnpm264LW3mgK6asPyG9JexTovgG6eIjdOFJQ+jY1YE3JHqOF420jIRoUWSYzsVEj3upIrawF2XgDHb6LcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=i4Lt/3da; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725345194; x=1725949994; i=markus.elfring@web.de;
	bh=0X5JD1dKXlRjMro9PE7Xoxlt20rlpE2CIb0nggH/kC4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i4Lt/3daxsTzXVqbQcdzqz4DeWpUFHPsA67NnLaf06eVWIzQ39hEszelNn7kSFWR
	 AZ4RE+mL+OtuKCtYS1ZvQnbqP698Xd6ZfCwDipxu/qmKtLGtGgetD3Fkwsq3p6F+e
	 eHO9Dw6Xw5pq+2kL8VyDzez4h0GB7+9y14KdeHtMy4PRf/EnCX8C0I36s5LUVg/Ef
	 90QEOxl+Bmra2r5V1cgKfi96IHpqizKevnPDAempffsObjx2fCCPJ2ZjBmyBDPz9d
	 N5y+DQJeYkAv/nONzXjq/u5Phv13xn77YhhqiL1cv4U1ypN0KamUpKtNGUfyd94eh
	 I1M4c7F9jTwFEcluCw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N45xt-1s3Xq705ib-00yDDw; Tue, 03
 Sep 2024 08:33:14 +0200
Message-ID: <f338a355-4ce6-4d63-8659-21b9d6c7eebc@web.de>
Date: Tue, 3 Sep 2024 08:33:00 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhao Qunqin <zhaoqunqin@loongson.cn>, loongarch@lists.linux.dev,
 linux-edac@vger.kernel.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
 James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Wang Xuerui <kernel@xen0n.name>
References: <20240903015354.9443-3-zhaoqunqin@loongson.cn>
Subject: Re: [PATCH v2 2/2] Loongarch: EDAC driver for loongson memory
 controller
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240903015354.9443-3-zhaoqunqin@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Hlp5eHDrSoTYVZtwFAtDx/TeawGpx05iO1xdWvBpc/dEbAIHHb
 mk2GdAM/RmmWc8X2mjY65VmHrH/pdO58GL5cLR+XpGcVFS7ja2Ebf0gDRBLzivF1YWpBFrP
 VTuafOk2YhupyuIGmEM44aLOZc5XeazfatyjqEHLohUZQXy3zWnW81ye5qwwb6pzTGK0jQm
 QyZ9BhllqMAtHliWSZRCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kkAEESP15LY=;CORj+QSknKwLWZYgR2mUgJt54FQ
 sgHt+w/sx+JlcCyaoE9dOyagoLj74/2W3vHOBTeD4sMPNSXBwYe9W0JOcMslPC0EgkbrwOqJT
 Yqmy8QmFlgJM+8DvJv9dCuoZT9X9yvQSD6E9V3xT2SD3UYeg5hmLXK/5kYW9FevcfdZgZja/o
 NaSXxJchzRmefuxJFeA7uLqCP2DAC1rxNCxu/U5UEOOkfkqkbs7NCugRylpJEfXe9YOMzOIaR
 CftXgqR1+//tEX1NMz2L9ghVekTkxdI6X963+ZnQ1RmHhbE6delAOF8tZwtEaACsE678D8VBG
 R6ZO5dK0N93cZLA8hYb1Ypgw9Q4qiZCpX3r236CuJNTe7BRMBpmlO6hwm2NSYGkOCgS64hAoT
 FhYEefxqOZy6CTzZ8Wac/bLSUgXXsCuYnPVa0NrLRYN9/2iPP435aS4Ll1dWSv39f9Dw6xw42
 RDG04lHXxuzYK/prJASUiM/YtfVF57MfaQrfo1Ow8aUmo+5dfaZKPT8BrdU7Vs2jNwpxX5gcw
 dg1/tbNQc/Lcehz1yhbJizpnoK6It98WKlOh5yyU7aSfIt0KSvhtVHr1ajR5mRh8tiYz2NGSx
 g4asoFM47jCWO+oJ84DD3nNilGOfpGMu7pPDlDTc9fW72OqxtrkOEnrlxxDYLmhYMVDr+ac1j
 8jUdLH+pPPZGyGvMPJvw2gmUQyVGsoA5cICWAnmUeNTnaNIsRrmGArYavtPWqVIffho5p46HX
 Y9FGVLM+CBzg8mfaR5sBinWABjv6O8NOzeyZzwS/wjv3C028g+E+tPQgvZTy6H/J6QVcvsGbN
 jVAjhWYcrj0/ACoyjda8j1uQ==

=E2=80=A6
> +++ b/drivers/edac/ls3a5000_edac.c
> @@ -0,0 +1,187 @@
=E2=80=A6
> +MODULE_AUTHOR("Zhao Qunqin <zhaoqunqin@loongson.cn>\n");

How do you think about to omit a line break character from such a string l=
iteral?

Regards,
Markus

