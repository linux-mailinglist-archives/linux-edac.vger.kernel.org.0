Return-Path: <linux-edac+bounces-1136-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC38CEF9D
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 17:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76CA3B20D97
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CE61EEE4;
	Sat, 25 May 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sDDJuVS4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382D15A4;
	Sat, 25 May 2024 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716649240; cv=none; b=AzNDwChtfbIPzwiUNCiQjSKIgEW3aOjcz4VOlI1Axgtff71+mcguc+zg0O1YlBT7ivVR85DJi6q+Ok0TU52n2KYwubnRSwUYmL4LM1bH+yx7JD4EYb6Ou1vhd5cA9N8kOaqS2RcmEYBdhag/bs7pLHhEp+lq4fJIkhlQ31SiqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716649240; c=relaxed/simple;
	bh=Q4pzHCy4+tG7Zfat4dTz2yoLFglRjI6sDCvu3SF13IY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=jNLsqTa7cp53ei2U+6viGexJe8ilk0eiaEznEZKLVL+6uFvDjK9fxIPhN8nzfKmsKoeGiS/MFLNhs825+o0x9bUEZSDmChTNcUHy6bNh7wsePR2ECj8msCYNLG0MzxJYvV77W/WwfROcSAMdGB5Mgq4cHbzrJNIYRmCLzKSYC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sDDJuVS4; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716649214; x=1717254014; i=markus.elfring@web.de;
	bh=Q4pzHCy4+tG7Zfat4dTz2yoLFglRjI6sDCvu3SF13IY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sDDJuVS4LuXtznwMdAZ99aoXYPLqs15tsCkafF698ZnL2gkw5UMNscR0AKFTtkip
	 qK8dYmTgdSs8j2cgyDvkCJz1cJux/NVB2U6wh5ae/ebrKEXYa7aO0TH4RLMEouQvC
	 5aXwanwKKG38ovLION3dJxURqy/hk09fXNzHbvMYvvH2jlGmT39Jc+Dcw+o/cOkeh
	 ywgUkLFFlCNl6j88hkjXuoRkLGwwTfJ8PxboGsDYqr4A4x12HSAgnKanBn8C/Mdww
	 Y4pP8a6kOOywKasPJU2u/GlVYTtmrLsUnZgZk6/0bdxoaF76d2t4Ed8/96Fpap3O2
	 Rf9TlT+fEIJDrTBCng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKMA7-1rwmVF0V7X-00SzY9; Sat, 25
 May 2024 17:00:14 +0200
Message-ID: <120effa0-b739-4fab-a890-559cf353c4ab@web.de>
Date: Sat, 25 May 2024 17:00:13 +0200
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
References: <20240523-fix-smn-bad-read-v3-7-aa44c622de39@amd.com>
Subject: Re: [PATCH v3 7/8] hwmon: (k10temp) Remove unused HAVE_TDIE() macro
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240523-fix-smn-bad-read-v3-7-aa44c622de39@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:18e4ZdRo77H94xd/yj+nZPqU3N9WiFOdAfqaQzyAZfEgBkjvxKl
 4izmT08RherBSjcEuZPvg27RDS7zQzB8g4JgU9UbSdTpbNiuoVTbJMJXKAREY3wtDlUYCM2
 RZD32oD9ykjTZpajRzQZY92YO9XMh4KSN1lLKXcdZg/pf9N0bK0NJ/EzisSpZMlspc4Cqhs
 Ek1YKAljWlEyRGfLyaxxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YXst0CnWAZY=;bWLS72JZhB6sGBWTU5Uum+GIYAm
 4rH0a+REkNHHAr2u+IVcvR/EHoB+ZwyA0AG6vqHmaDd+5+Zde/+x+uUxVCE/QaDh2Si+37Cb6
 d0XGxNa5p91vYKiREq/kuOQXWe06k4WU9LZYCfza45OluUJT9tj/Kixy79wcAHN2zEURzAYKf
 PuQb9piTEkG5tLE3Z/icLoiPtGDJX1QUsuHfupvQH8dTZjTmKY6ORYhMDkbNgYoNO28pE1zn5
 f49Yr1n/HQ0x5ZEHnmZPeHwXVms3k7TWZKXqq8MUvEY5O0pwcUdlMSkia+ivWTRPsbu3ONdCY
 FiHSzCqjvvMVM+52FquyXCtYpZYQIpwjEaO8emPu60kIjWdVrgvG7NZE5izUwB3Z4tRn2mOyt
 UBBM3X0a4qRFIwIMzRb0Z4XNoXyJUmBH/2DCxedH3+jJzJ24ihlyTsRr8HzeieKBNSSKo0Fqo
 gd0Trap9tteWE02mqYdcGD2vYEQd8/S9+FXRDnKeB/iKmzHJIPaLO12Q6HnPEl1iro5UEa1ft
 WPyUXnBpetGunVyUI16+Lm/3rYjKUm0/HQZN3Obx6L6ec5DUmC42D49m8fizuwtaoFUY2X9fx
 b68Kk3PGcmF4XjgsXWJu7z1Zz1hOzumZjQ/6cXK3Nx62Jxb9enqVBilfN0c2UkWlJFAF/Bc5W
 37mryidQGH20pASj5NLpbL1YSkyiJivZQT0DGnBsVF6kTAeCT9DkIBoM5GhoZp8j+pr1OK6LW
 WHGktG7FwW7tGWVsQSZX/tKKeWnhfgH7/pp+p9Qzr5wkFTboJoFOus4sGrmKTO0WPjVmeDtdH
 IlnN0u8ZSsk4OMiJahSltaTDDjbEJFnva287vhtRdUGBg=

> ...to address the following warning:
>
> drivers/hwmon/k10temp.c:104:9:
> warning: macro is not used [-Wunused-macros]

Can such a source code cleanup matter also for the tag =E2=80=9CFixes=E2=
=80=9D?

Regards,
Markus

