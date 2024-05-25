Return-Path: <linux-edac+bounces-1132-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0E38CEEF5
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 15:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFF41F214AB
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 13:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BD43E470;
	Sat, 25 May 2024 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G8dNiMUb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B4A101F4;
	Sat, 25 May 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716643377; cv=none; b=T5BugqcDnB2u+5IapwJu1Am+uYjoM6Z9N5OjLLJwXc0RyJb1UT374ID40ouqt05FUYv8ZF8HyIIxDQH2NKy0taj3aJz8HKOXfBb/95BobOqDWyK8v4e3VABSDMl8cesnBWg0GDVOxlT1G13rVIGjQ5Zj8hoX1hH4j/ineZFNnzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716643377; c=relaxed/simple;
	bh=twZv0XwD38Sgrc7cZswUW04/P8d8QPz8QlGCO53cniQ=;
	h=Message-ID:Date:MIME-Version:To:References:Subject:From:Cc:
	 In-Reply-To:Content-Type; b=Z85e7zFBUZziUjtf7QJO6iIIrK32PjvgDRXASF0Zp1EaQKdBVoWI1Wz3ZdKZRAqAhY9aiZHu7KprF+a+1Tdm7JpZDQeVsPM8clS4m/0FURY18DFS1AH6wwba2x1eJKJMrAqMhp0dRnFIDSOM9VbIE19uiZG1cWLEAan4dKnm310=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=G8dNiMUb; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716643351; x=1717248151; i=markus.elfring@web.de;
	bh=twZv0XwD38Sgrc7cZswUW04/P8d8QPz8QlGCO53cniQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:References:
	 Subject:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=G8dNiMUbwUKjzXMaWkHcvdLfiXs3jWf45cPgiEfjG9T0zQLr4FYfz/Rp50ihAv6B
	 BX3uWY8Frx9sfjGK5DIM06ITMTBpe7SIUfNKwWg4U4UAo3rChE27JwikO0wizsE/E
	 H/g3L+HJ7ju0fDUj3TAeTUTMmtmCtbeXl+UebmdhsOu7fcaGVolL3hTXV/J3vQ1WJ
	 MdQRz3Hb1CKSRC7j5ohuT6arVN9zsPQEN8mzmdwmTjSgXwoNdSQG/R9O6uqotGEZ8
	 ot+UZHOn3bx5IV6QNc9VkGxz83Y1eCT7cgdi+SaonN00zmP3K0/hzf401e/Wbhl5A
	 L/H7lVrArypDL3htfA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKM5z-1rwloW2E4l-00Lxhx; Sat, 25
 May 2024 15:22:31 +0200
Message-ID: <e084c47b-5a14-464e-b2fd-bdfeb9fc8dc3@web.de>
Date: Sat, 25 May 2024 15:22:30 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
 linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
 x86@kernel.org, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>
References: <20240523-fix-smn-bad-read-v3-2-aa44c622de39@amd.com>
Subject: Re: [PATCH v3 2/8] EDAC/amd64: Check return value of amd_smn_read()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240523-fix-smn-bad-read-v3-2-aa44c622de39@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h9m6DHXFR84RKzbcIb+FaTFLgvibH9mmJn4paw4Qt9pUSGJ3Od1
 nQUAbZjvazlKRaZs06sabcarChxiTkFHP/IioLOfUxtH0DRQsMRxE1yv5idWv5zrt31V5B0
 dmKB0k7L1KBbWmV+aXsNdvQpri/fsQo5D1RhqDvhJC3m1260hp29FChdfklFTZsGls5kk1g
 ACkGD3JXkFUoxBx9ok6DA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HMLPTIJfApg=;xDoy1xlEVS2hpwr5HArNs8O5zrr
 nFRNbneLkEeMvq80JZ524EbzsyU+rZCOwFK19GKTluHxPj+wsBYkA3Fje7mUyTUW7chLCvqu+
 O7ij7zgkVJHsUGMS7H7IIwARcZ184JWr1WzEBNTiPiihC0OLG2xE/EQfSddPT8JDE2obEyAsS
 PKsL14Omf+ykRHbNjllJwTHNdJyEY3cef2mhjvUG/4tXkdd7yFNwGqkbASxvOW5W9EskPuAxJ
 Hi8g/6kylZXZp6/36vUpriq1+Cn6ZVOp4ZD9mj+cu00vP0Qj8khuHAdsWo6M1dJ8S9M6U+gq7
 50RH8XIMZOfscfQr4bmyLBdTdcP7e0Nh2l0M+FrsNXW1gIj9Rzm1Es/R8oP/bXA4xq6YW2hKE
 iCPQudJt8TkWaHeVulvPpk5GLfqRcTdmJCaYEo1sE/BrSKwfiFnNV4rBGOLVz6cKjEueh9D15
 pdPLGPli75AA48polfPADoRbGw7KKMUAoW2IwDzUg3/rySTTkI4X+f6mvRnyVxOVCnYpuh9JD
 PMePvSXaEibvEQUTjFLPRX3YU/+Czbw6UmGk6lJL/x+cenMJnxxTDEe78GG3W7fMBoxt5JmV1
 Dg3xPL8FwN4Vm4SJUz7xzw1RNrHbojLaaU/iR40KywJ3fKZNwLEcZA04exVXwup9Ld3S1EczF
 qaVdNpweezPoTfWEfD89R0vW/Rojr60hiX/BAqPiL0CaWB1q0WmVP/WsYDmnH3oU83la3i/ss
 h1mLED9x+wsSwJQr0JccKP3ZF9p41+SJa1aNmsXNgspYvSUMsqBZG/8SOrS89edbHzzd5/OxZ
 NEorrtGdKE9V12OktZTdC2+NTP+mh21mlO4G/Ahnm8HDc=

=E2=80=A6
> Check the return value of amd_smn_read() before saving a value.
> This ensures invalid values aren't saved. =E2=80=A6

Does such information indicate a need for the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus

