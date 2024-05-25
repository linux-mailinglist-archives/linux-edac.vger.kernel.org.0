Return-Path: <linux-edac+bounces-1134-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD6C8CEF2D
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 15:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3100D281954
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7745C4D9E0;
	Sat, 25 May 2024 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pjCtGx7S"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1309B652;
	Sat, 25 May 2024 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716645363; cv=none; b=b157xNXY8bIW9sQQhUlgVW9w7zzRJmglSOD+JUJRU9t7i6lcVqorUtOND3cpU1lY5p+BXU7QHWMZGFb+sXbYWHP5bkqX0fHSdRhutSIAuyJ65WKoyCNSvyyq7eJNFCZehKDS066+qOsaO3WXKZXuCa4rmwoOC4wouOLSz6khLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716645363; c=relaxed/simple;
	bh=EDSZ+t9eeoZ/S27lFFmK0yqgyDG5QixJYOls16lDhyo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LFiBJ/WY9rxUMxv0hxffeTIN7ALCOcODVGegg0mK4rpVIfYcNDrG+H4i72mm/MKmHnWvPeTlroROyaP9CEs+WxZtq7a5rPXjJ6fMsRTOwHr5bMw5Ir0PMPIQkAmYk5GFvgkjbShkhlIkPANA8vAlOAFAMdzmS6wUF160a9Tah6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pjCtGx7S; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716645339; x=1717250139; i=markus.elfring@web.de;
	bh=SBXIH9zX5kPE4nMYQkrY5M0b+lEnjHUeuUIGpZsKoaE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pjCtGx7SMqtL/2lfO9n3DM6tDF5e8WE3CSciUcLx43VWgvhUWvsmW2jGr6ZQJOi2
	 f0tlwbgHp5cfb45DfCF9yQf/C2hOhDovSS1x2IINYyuzeuE2MAQqL+2dzY0MiAMEL
	 vNB47NrU9bRlB7Q+eG7Wo4KMShELi5yInCt5YETmfyb+wF4atFCDMi859hCb7VL8P
	 g23CbzJCNsmNXj0Bhswxi/W3pAsvLUk/Ar7gC8bAJPueDZovIQQcPaymgNTr7We3B
	 1xLqpGj0owbCLywkOTHw7OjuL23hxOqTSNtjIqmxPUPsH7Xx1qk0OFvTGnh77sxXF
	 M9xUKEiDh5Q1uVfxNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOm0x-1rsNdt45ct-00XLQj; Sat, 25
 May 2024 15:55:39 +0200
Message-ID: <8610cb8f-ad3a-421a-8a85-4c498c8fd0bf@web.de>
Date: Sat, 25 May 2024 15:55:38 +0200
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
References: <20240523-fix-smn-bad-read-v3-4-aa44c622de39@amd.com>
Subject: Re: [PATCH v3 4/8] x86/amd_nb: Enhance SMN access error checking
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240523-fix-smn-bad-read-v3-4-aa44c622de39@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:urr3nIG7Roa28FTFjHGAy9EfXto9s16eYPbCl+FfZ32ENTwuq0/
 aoxWA2yLKf5UDJkJ227ckGg1sR+KkM1ZIc9WE//RcMwZLF/HzYzpYhuK76lFi2gqtAS0xV2
 hhX7BGuYUU5CSfq3KcuaXXiqLNDdt4W42UZREwL9u2NdApwOI9y/fyBzBhRSCYpEjNNnlVE
 4xm/UmBBIbffbvr90FGJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fABZ+vIg7vQ=;Zinq8XQxkn2Hj8SfC88xZCe1mFa
 46f864MhCTkr9wv+qjGhYxW15ggV4/UgmIJho5W5vv5erKQB7qFfDJTZzJDQv/Z8TbnaWWLdl
 Z3B5uOVFClQjWjKOgQRKUs0G5xbCrW8SNK9TkWMBqzE3JN7767oEqwm0QHcOLWmE27QqSXiuw
 ++4eLCxsIzkNbR/eR/JgpDmlttQYcvd/QME8SkkPKFGxNvdXMxzXzBHTffxNFZPaDFHcGchLC
 z9qFxhX8nfab+z23fHn+pB6Y+nSZvFMyv6b5h7DlnjfJzUudhsJ2TfNgafNDOUPWIis6h/wFz
 Gt8cZjgG1gEyWfiZQxLg9trIieSuhqhSKWy1APLr08VBbDGr2YO9xyne+FyL1feJSl1SbAY/n
 b/kdysyGWT5GvKb9Ej9ARhn0yWeR3nwfpjPQdsfIGQUETfZfVzetfhPFNTyEMLcLeKDZvFaFR
 KGUnPLO5AQ7HGctXRAFTGLgq3rGew63NxRcQU8IrE+REK8kfmeY0g0psTQ3Aoj9meXWGdkTDG
 IK/HrpavGRxu+EBPdaFktwD9CnL5ZmhHeOd72Y0JkQrfq4WGJwZ+uMq0lsGgQTyZQW8pFgvod
 pia2wE1W0XUx1gEcUfMN8DVxb0PdM+S2UvRJ56cMe7uDW1SlzOdcXUeaeu+K5x7bz5ZAEl36M
 pjWIMLCRjEahiYEn0MiyBjbGw44EOScHL6bNYHFlvS+A0E9ZkX8j3AkOx1Vl50gIn+HhcrxWc
 6mTExFoIsfnAoOuzrS9JvNr3dUWy3bOYzRf6iSrK3S3pGrTG16VSVD3FPYyPxET4FEBOMqZxl
 /8KNuFx9wfcCQAXEvjZyloGNh5OoVFMyZ5dOMeLiXqChk=

> Furthermore, require error checking for callers of amd_smn_read() and
> amd_smn_write(). This is needed because many error conditions cannot
> be checked by these functions.

Does such information qualify for the tag =E2=80=9CFixes=E2=80=9D?


>                                                 =E2=80=A6 And remove a w=
arning
> that will not be trigger in many cases.

                   triggered?

I suggest to perform this source code cleanup in a separate update step.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n81

Regards,
Markus

