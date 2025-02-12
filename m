Return-Path: <linux-edac+bounces-3035-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A798A325AB
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 13:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAC6188AD40
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 12:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC0D20B1ED;
	Wed, 12 Feb 2025 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G9o1PLaU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC7271822;
	Wed, 12 Feb 2025 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739362155; cv=none; b=qAJtDlaLhWqrqQ8U1YDYJAMCJRtN0PO55Yy/hAkDROq1Qu5hEaWTQVLqAcNQYdaGMqudx/buPcAs2Mjdg7NP6bvMthddhV2ceA5bHCN1CCGBFnrVcTq5pKaQH6tXNeQW+fU6dISezc9h6neOYilmLgAnFBqc4EpwzvWTCZ2pHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739362155; c=relaxed/simple;
	bh=Vm3zqddiaQiFAR//aliDzdbsYBycePtZ/HzNM1/y6QM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XZ06u+fTxUfjTZQfzC6c6oGSUcUEY4eCC0qgrZDv69hvymyR7FiMsCSnv75vMCiYwQoKEcoOG72DLV70/klWLCZ+8MPbn10/3UNxY5pqWodmtQH6b2rhw3w1CAXV64narZM8GG4yTR/i416Y9+sNWfMAeM4xxoYI0bPvTXOHs3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=G9o1PLaU; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739362130; x=1739966930; i=markus.elfring@web.de;
	bh=duDd6UKIq1X57ebMyhME9oa4JR/K++kmZ6ASY94gwig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G9o1PLaU7dvPrR52LvJ5TsISeHrBnD/OkcjneppoAV3V/9JWIRvZfSG36dex1TJi
	 9P0SUXGlUdkLxA74vZA4sxPB9QPGgq33pcyrXTntEO5G9RI77uE6I5XmckBdQrnF4
	 dW/ZBEXtQ+PxtmcPUCbaiKOEP403iRqM9Wawehcsy8+YSAcaTuvSZsOqFSmopOZFi
	 hcZ/m2znsA+0aOEAorZj/I41zbsgfeF9A/8j/3GNIOD0HWDhAsOGHfcUjEZ9Qhyro
	 VIiJw1tzfo43BLs0EIBWk5qk8MlZARUil4ZneU/WkvNsY3SIoggke0EE8s1krx1an
	 8e9p4r0WXI6x5sni7g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.11]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzkOL-1tVCzr062z-017tgD; Wed, 12
 Feb 2025 13:08:50 +0100
Message-ID: <ef5b12b4-d7f6-421e-9339-8621fb672021@web.de>
Date: Wed, 12 Feb 2025 13:08:38 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
 James Morse <james.morse@arm.com>, John Audia <therealgraysky@proton.me>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, ramses@well-founded.dev,
 Robert Richter <rric@kernel.org>
References: <20250212083354.31919-1-qiuxu.zhuo@intel.com>
Subject: Re: [PATCH] EDAC/igen6: Fix the flood of invalid error reports
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250212083354.31919-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dcz8MeYNQcc3ndn6ErODct7FGspj+2rulOIoUJyBX8fkaysD8/H
 Z71qvaDsVmR+WLfVhGoDKQg8S+blyANPvX79JCWyB2dh3ADQKQkRQLo6x/iz8kpl3abrCj5
 SA2COkNZyHl8ieQKbfD+ZVxdPCORyFplBIUXtp3X0s61bXRisLGew+9ZlzmUlWmK5KM/RZp
 fgTmPt+w6bDS/LVeKH1/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R6y0rttj/xs=;EJH1+wh2JXpL1QZHpUIrF1UaOH6
 T6cj8vzedIRZDcMuz1trh5/DlH9KtvutS3+GMLbWDD/k4cAQSxaXaWU1lQXRUXTKqmxIzcRj2
 Ay/Hp5g02V0U1FoWpIZOIbAOqUl1t6nK4AISBX2TopTXOGq9AUG6YVTrahzgTv+yeNRllr7pZ
 6+v+30rDC9heMUWLPUkIcG0m6mTu2IKOOfcl0t7z5PZCxAkPN6suuklfgqzLMh18PMXxDcfP2
 PwFu/6ho38knyf3Rk/YuHoN6rHrlHWFXOCCXnQ6qW6d/FVlIKMhNLN2WZfUT0Oieb1faO51Cc
 ADHouCD3efi0/dbACI14ou2TAM2Kbczduf6jipuqpU+H4mMrbyd4dCVZ99a8j2+J+mYKo7sZJ
 k7cXRjW95JkO9crynochtENaicKo6PewuNsCd+VY4Zl57SKC8LIeKGsBPpSmfZgGzYd3XVKoS
 bcDj6Ga2BhYfuM4xAzdH0Bfh2MxrC2b1ZNHY1t/WnZx4ul4aWJkUR/8Bhxay3TwlnCwEkCo7j
 HIyvw9d0At5Z8JXPbqNUZEJVus+do7FoqcjB7okosn6q3xFLEO3A7RhhqYP3+0cZIUZHqUdof
 P5p6N83r8yljkQaBGIe+xBG4V2rFqXHCM+xvVIZfHGlxn3erTdzufrmtMrDBk1WvtpNYo42uB
 knTj9AhXCcAfEb1OwMxEkOVgXRdVDqxdNVAixvIf7sh0xrAcO/qHk4aNcKrCPM1DRlOsstuQ3
 a4PdO43xqSgtfWcN+PjvifVt7EurRq6C9CUtQHpEC3RFTNJXw6tPoISrsK1Rv6q9fzz3euT4g
 b7woEfpDRc4ANkK2G1FeEWlZl6q1yZ2L1Hk2M82mSFng+Q2GAyEHWQfcOYPiVeEQW4juIKJUw
 9YALQACuMzzTk/T7c81+ZYXxzfjeeQFhvXW0W3nZrxoq8J7Ho0APBE7hPtBM5+k1N1v0AT6L+
 xhvuyIcGOKdEfroQ1xPxha4RmmLtHNYJGtdTPZYRFzEXqb4jubwRq/gj9XFX+BChacmZHmjeg
 Ogf1g3tLUXYf9FezxznFTCpw02Um3nchbN5ipyou1vR/k795josH2PDhuOswyHet3Nk5CV+pA
 Kjtzn/MiwyzQ0/wXvGVAtwbgMn1MR1GGB2E//MP+XEtXRQpZLvtKgDBZkhWzXK0ox8puYZXZd
 NXDT7THPX8A8frSPoehmAUujvQYCcnFg43GGCTKsJrOXXSst+B9FOSGTCR+79QzAC18MOdnch
 Sxj/CKasrjABYMBhnOHv5wx/pIiWfQ+NPGiILvPQcNAyD9ZBaj/KwBs+skW2SBIqiJgPz8AE7
 9DBsXEf8Vb1aB3wgerbnShM/jtoWL7ESrZ/WsTLP2n8dqyFubctSRWD2j9MrJhv6QXp42C8zl
 wJBLlN4KzI7PtLz54Md80XwSKLOqOIgrFNlhrqGCNENTAoWBNTYwi6/zeNwQUzJxwTEFIWDfC
 wTVijxw==

=E2=80=A6
> +++ b/drivers/edac/igen6_edac.c
> @@ -785,13 +785,22 @@ static u64 ecclog_read_and_clear(struct igen6_imc =
*imc)
>  {
=E2=80=A6
> +	if (ecclog =3D=3D ~0)
=E2=80=A6
> +	if (!(ecclog & (ECC_ERROR_LOG_CE | ECC_ERROR_LOG_UE)))
=E2=80=A6

May these condition checks be combined without repeating the statement =E2=
=80=9Creturn 0;=E2=80=9D?

Regards,
Markus

