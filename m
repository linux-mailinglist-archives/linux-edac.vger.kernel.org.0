Return-Path: <linux-edac+bounces-1133-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D5F8CEF19
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 15:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126351C20993
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA69A48CC6;
	Sat, 25 May 2024 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YH8FdB/l"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91C3B297;
	Sat, 25 May 2024 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716643953; cv=none; b=A+QvJqQctuT9CX4LDWYDIt9hlOGuFz+oCbqaEM5MxfCuLeopHhrLd96W3weoj+tidauE5Fpv3Wiv7KiV8QrL5lT0LRtLWI5QOjKslcNjUMSYoeWA3OCk4a/7cwUooy5RfXaz3Dl+vcMoMAyuEGVMZxdn0JY7h8cqzGzbwPv2BTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716643953; c=relaxed/simple;
	bh=JP4di3yKoXAyHQTDL4MSNwnDqzZtn247np5kkTP3B5E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=C77+G/ri+RrTzQxh3lIcnI/JsToaFhfoPBlLFo3Jm2RSbOOeI1xXOHPsG9t61XPCCY90sFg5wI4VnY4G3Kie+Ut2BzS63Pp1XQVE03UCmsuKINTODR3bYWH+syV+/CNPwaVvUg5W6I5Bjen1UZwb47KBwlxQfbSU7XHcfJeqH/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YH8FdB/l; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716643928; x=1717248728; i=markus.elfring@web.de;
	bh=JP4di3yKoXAyHQTDL4MSNwnDqzZtn247np5kkTP3B5E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YH8FdB/lUS36NPdYcOmahpPmRDpyYvatL4dKxuwsGKOlL+rnVWvxwupeaj57IaG4
	 RIJN8bCtxZhhMswv90aLMHq2KRVa7o47Z/+ObN0uYRFFHCRMNyQti0ll8EUPytuc8
	 qvlAjYNmDMH2fAOlmu7TIPBDDJ07ziq/itLCVCryWCqHfq/+kUHD/y4yBT5YYe/ld
	 hsyc7iwvry4f5XD1TJCgw3gAYP0gOrFpcqa/1BeljMURfMob0w8g77NoLz8bA3qiq
	 EfqgmOYE2NW0ti14zHrZ4+z7G4pLb9tX6CkglA6Qgs8E4nmE6ouhDro5ZQqueofo3
	 JLxSqNsFzizHDEqAvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M28SL-1sCmNV1jp3-002daF; Sat, 25
 May 2024 15:32:08 +0200
Message-ID: <8e3cc13d-c2d0-46f9-82f1-67849c6add91@web.de>
Date: Sat, 25 May 2024 15:32:07 +0200
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240523-fix-smn-bad-read-v3-3-aa44c622de39@amd.com>
Subject: Re: [PATCH v3 3/8] hwmon: (k10temp) Check return value of
 amd_smn_read()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240523-fix-smn-bad-read-v3-3-aa44c622de39@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UMwIlxbVxCxbl6+EBLJ18Kg/xiTYPFfku5uWGn/ab5Gh1o0V2uk
 a6QK2TsSiLBT9oGRgqxWMsTpKCR5MfSOYsYfHYKG2brGF4H+sqVvoUh1zFYoiAhS3z2nZaX
 O0veVbiNYcuWCaQT5Q+7RS33eXHU0hDr4P+mRGmg6bJ/8JefgHGUTWpHBX5P0kZw0CtlIHo
 /jVZ4rSp4bjzbJzSBHLtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yDbl8Q/FwLo=;Pl32SA/RLxsVM2tVdUy05gy+8cL
 rLcmEhxZMpBifK3RveJ+MiJzAeerd83AYXJnK/y3W+kH1Iu00/36xZqkwFl+oybiDUBj40rrD
 /VNPazUX3dLgkHqU+hch8zCVGwH4EAnEIWNKC8iJBvlriYmJsN8XOvSG27/YWilxcmaBPSIUw
 1OlVdI6DIRAgt56d5kMp7GFQPSabCA+WjZLS72uRqrE5QhSCR3jiFlBM0Jj+1zBcEpdvdNGIF
 y0VAEd/oVHsJYoPqLiQfjRbChs1ozd7hlR3BzDYQAygHs9Zi/dQajClIF23el1qWm0psnBT4A
 hvVxiENowIZnLSV/rDFPAYcNe1lHgFIWAnXI9tFjgoEjtOQ0ky2iqSAOoK3czuLpyY6VWkSjH
 hKIExLNaaG2/DntEBjz8imfSGkt6AqDXtLhBVFLd/vhDibUEFr0GjUSQcuQYXmNKk18nugJ7I
 Pk21v8Ir68cAFjbwV649aZfbgYIA6dYMWrecsSspBrm6dhQeuokLN3yttFDcXud0upQRaxyij
 +0Z1idxC4ilmUFduxKqlqM0u88ecj0vMXNLX/QbA5RhmydBGOvSoP+WsUklu1cVma7TdeBxg8
 wvMU1moMn1/Xbj13kEKn7MaHpXOhyw1f6jnExU5T37AHdwlhrVT8x8hLIs8EjjJBPurTVLzFP
 rp+cJljGoIO8qk+gP1MCtj0pSSctuekSBWQ7cgM4W1pUOFwjKqn+IuZA3hkPD6OI20etXZfMu
 JMJ8GQrmqh8foxzSBSRli769Z/1m8q4udZ9CJ712ykVAoO29mYI6qH2T9uXxVUtSze4XAv3O0
 RBfKD4ZK6J9qfF6nG7uZNn3uzeYhQOpo4Fxsm43EXrHBw=

> Check the return value of amd_smn_read() before saving a value.
> This ensures invalid values aren't saved or used.
=E2=80=A6

Does such information indicate a need for the tag =E2=80=9CFixes=E2=80=9D =
once more?

Regards,
Markus

