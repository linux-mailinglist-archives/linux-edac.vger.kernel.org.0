Return-Path: <linux-edac+bounces-1135-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0E68CEF59
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 16:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFD61F214ED
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224DE54BD8;
	Sat, 25 May 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="v9GRPg1K"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E0357C94;
	Sat, 25 May 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648226; cv=none; b=gO7jKsQT+ZynBbQBb10NGJFZvtSTT+upiE6ytIhad3E/Xv1MxhPc9Lqh/5l0tSr8JCLsT2VjBm7FxTETXZstWF/9y72h0y7gMLOHLXc+agB/LS2P6Ik/QI7wy60qspYA+6GlWU4MvTUb4pyyylcNExP5h7YSTQPEaiDEGvoQU4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648226; c=relaxed/simple;
	bh=fkcSscRVePBzClU/ByafnLde7oTUX6HZ++aSee07ccs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=aK250zl1sEBPfr5oKmktA0lmnIlFLH9GWuxv2sQVaNr0yQIX7nkk3hvKp8sv4QWdfPJZ/vsDju1XKYWLKgEVE+5KEeywiW7Deq6iXAxjDzjnHUbBmne5LJJiI6tgJqOTcPzJwNTGxJ/6Q1dHuGSSbkORHLuc6AwF00B2hY75u9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=v9GRPg1K; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716648199; x=1717252999; i=markus.elfring@web.de;
	bh=fkcSscRVePBzClU/ByafnLde7oTUX6HZ++aSee07ccs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=v9GRPg1KEYYrxlY/tsE9O4exPHM5M5OvPE72/MZr+cv0S59+jLS5PcLP6YXZ9xnU
	 zndQKjjrCl3KQMhc0INkNTjEI0KDY1YnoDn2W8UnyVZ94ghyACYIw+i0OgIi+rkwr
	 Eu064jBbcdMMznekVEnIYk4C3xPFFy0VETsMnC6S3szMD2OTlG+lNWOZ12RxsckVc
	 AP4s1v6oBpwXEu9DDLZWwj5eCcvN/nxcxPa1094c6ydVKuBABNBOv4a/RamzzVMfc
	 YglqBkknmagIw/ZZFBuDGH3TWsAi4hzD2XvKi1LaLHn/w1iQQr87z9/epqW+NLSWP
	 u/OVpGgUZXr8qahCGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6K1l-1sYXLq2s93-00zZ6o; Sat, 25
 May 2024 16:43:19 +0200
Message-ID: <cc397371-cb8a-43ba-8a63-98856b6fc0ca@web.de>
Date: Sat, 25 May 2024 16:43:18 +0200
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
References: <20240523-fix-smn-bad-read-v3-6-aa44c622de39@amd.com>
Subject: Re: [PATCH v3 6/8] hwmon: (k10temp) Reduce k10temp_get_ccd_support()
 parameters
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240523-fix-smn-bad-read-v3-6-aa44c622de39@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8e5ILg0ccv40lWaOtqg2D8SgzVpmxsIPIOXqqOAu2EP0gVU6f5h
 dMXEsFiyjFLeoa8OKIncw3mrV1ziT9Ioexl4PPU/UHCqytDerJ1y0n4UeFbQA7oePWkAAxs
 H+jic0ZGoXtwfYJRmDrBRmmM38jsNHsX9aqOcGLWyfWnxFuhx8tyTjCsI7iOpESHy6aCEeT
 PKTx1pj4UHwXXY+02MwCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ull0oJpgIdY=;FurdIMuXMAktoU+xEw8OTdQmBM6
 H4V1sd0KyLKThgT0BqjK4U4qgNJLoHXQCDN8GLrvum63kSTIFlo6ElI2R1K3gwHtcuFVI8iW+
 iTitMPLjrb0Bq97Y3+IGhBLF+fedpGguAK/rET3ZJXi9Q74FU5GUxsamNWq2Xu2ZtBwomuLax
 XzYFwJKjWQc7Xyk+0FwG4+cQsXphwL2sSD5KVDZ9MdFlTVb2PAVYbTnIygceQGQdVcFYy5SQZ
 3DuXODfb8d+x4xQyfyg9fG3SiV2K3PRr3kxeZZT2NAMeoqZ0vrTbB6OmuXwuMfIcDEJtPbQYz
 oIJ+QLnX+BM7T7MJXSJkQW/EiCHD7inafmV8Klv2i+Y7B4CyIrFr5+ktVfXpsYEJ/rQBOq4Tt
 QgzIRcUYdJWbzyeWXW9rCWd1nbnQn7UPwrrtCjWhyQ6+YVybEP8YlQ8gbGvvxpTYIIYN6+tV3
 ooTANPcM5EAAVBqw3oaN1+ynYRsxtReQ8zMNv5WLt6kGMNkCNyhz/Jui4zkxNNBu14M7kkNFI
 Gm8maROV1S0eQQvMFwshe2tikAKBhi2Om3PxYApcsyPwCE9SxQSp1oKr/btXMEF+aM5NUXYzv
 ICRHVL9dOlDuvpI2HywASV22hYNW+UkuFt5nn3yIGoF0trtrhWbUSu0wPLCEjr3oMr2MGsQJ6
 hr6vPkdnkIDOmvx5pjLdrrkGGHj2MJkZZC+L9yiJrflv8hePuSV98S0bH+brX8zBfK7TgLSJp
 hqqkec4Fwbd927OCemuYrjSFOsS5dXvTyABayG0BhnxTVbPRIdf0zfH2TpxOidPNe5ufxi+iC
 BC97E8RAwauT9GtGEarZjc/lIl+9m8tzY3tLUfofY9eB8=

=E2=80=A6
> Drop the "pdev" input parameter as it is no longer needed.

Can such information be relevant for the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus

