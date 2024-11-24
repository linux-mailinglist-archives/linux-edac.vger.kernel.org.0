Return-Path: <linux-edac+bounces-2631-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37009D6D32
	for <lists+linux-edac@lfdr.de>; Sun, 24 Nov 2024 10:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4197E1618EC
	for <lists+linux-edac@lfdr.de>; Sun, 24 Nov 2024 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33633154C05;
	Sun, 24 Nov 2024 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GvW2mcob"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43C54F81;
	Sun, 24 Nov 2024 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732440091; cv=none; b=cqP4RlhFtSmpic/lSbzFDDF52x3End5E2RbDI9Z2nm3adIN86QCNG8Q0AM9Y3YzJtBfinlLRS7cgEgX2RGNsMkm0IVIUzihL78pXfWq8yZGOnUBaGBWEwn+3HVGNxxNLnaLu0Mgsg7T2mYUoczbEi0Dhr6pvpbX/M1qZC4nKwjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732440091; c=relaxed/simple;
	bh=v8fi5KpHlWUfeugw/k5hxCTWOtC4VK0xKjbcp5nEWPE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=fH6GZ47EXV0UobMVx3fHtMSiNGdbPE2Eh0nZ8/+6FMhFYKFlzfh/dDtPPQNnkpboZivHyVQN0tkbjwEkJwhHshCEQpjME2gmPW0N7dhyo+PVbhHDDNa3Cl4LDi9azy4om6u6w2pdSG5J+WqxZZGNxffzW3m/Bf2/EdbvD85dQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GvW2mcob; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732440064; x=1733044864; i=markus.elfring@web.de;
	bh=v8fi5KpHlWUfeugw/k5hxCTWOtC4VK0xKjbcp5nEWPE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GvW2mcobfDgAnxGfyPepLRfIJSmd7S1Q5ENk29HJz8+NhaeWpTpFHp8cq3LBSoxA
	 zyYu9zLWxdXm8AKK70nICn1VK/PNYwSDCx9gcF6BRcnzxgU3d+mMT6KX3P8JW0GIv
	 +oZhnYO/7Fz24s9aseTS09GxCCL2Ggnp/sTw0VI/dj/Chw0/YEOd87BKuKmdfnd1d
	 zR1CBipiYeGO2fDy/dQ0Ootwr9l525EJoPbq2gtaiHZf9yHP4XukOg4Sem13w/0hP
	 DYmvaZiWsfLO4dx+LC7iXXBYTxt2FsfO0tQuKDrz+3Beieh5jqSuoVFnHWiSWkuWm
	 MM9BrSSiTYWUScjrDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIyeG-1sz8O20xgo-00MVT2; Sun, 24
 Nov 2024 10:21:04 +0100
Message-ID: <9c8cbd29-1ce3-4716-8e13-e13b1e6cdab4@web.de>
Date: Sun, 24 Nov 2024 10:20:53 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Karan Sanghavi <karansanghvi98@gmail.com>, linux-edac@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241108-coverity1593397signextension-v2-1-4acdf3968d2d@gmail.com>
Subject: Re: [PATCH v2] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241108-coverity1593397signextension-v2-1-4acdf3968d2d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xq+95ZlpW38JBwfLOhfe1LdWfyZ4scfk2On3819YfsyX6CY5bo0
 miVnk15AoF8ICmdSKu6tyif9QAF3xmtQ6a5aeiQoOm84Yp2D/AniAuf16JfS6VbH99sgbcp
 Y63bugEqey7YwuRAyEA8Y8UOfa5uvvyqw4NDg+4Mc4zEGCfn7QNYJJ/m5POPw/MEM5IDxRB
 XmPnZhy6UmnVTNr5vLDtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aC6rdQ0prLA=;Epp4A9dfVP8aHfBQzomxHVdT+6T
 VM2VVCsQappLV9/5izqu3O2/RMToW66TBojF7KiVUdErr+yi89UF/ybFqBMbHwOM924eGFfAE
 5I6TNB/UCbYka8EvG5gxzcOW32UwyNkuq2wMKWHENNLSOqVuF7w9LXYJVzp6iiA81vgSEQt7y
 DZgDEXaUVfWC0p0/einvcCUP9p62E6KcnhBLPQoAa4/62opxcGHLhBRmeGG5EZhUH3fOutymV
 n1EKSmR2bnIAUFwFiA6jQR7PcHymO3uEmiorfv8aGSd8puFdzTo/iPiTVnxn8AF8F7Jy1qwvT
 sOc5aezisUsD8vjNk5sqQRLZekeP4x27b3Ak0/r2d23C1ZAEk8K1H/eo7kbWzoCyNAsbNeTlV
 pSkhACfnsdmcCnLH0XutlZKezs8fIqAxv/GWu2vE8epUNovX0OH/RYYMunJkdDVOTVnj18Jbe
 ISUQY+DqpWTELb3VTjIFDhXRNF8bGo2OcbKPrYVlf7BD/xnmLI6tEUINKMK9gdukFsUL3cFwS
 6v27s7JpsIA2JwkQ2EN6dUdLzGP4QuQjHHWmvYDPoVISf6IiWmoNwg1oSMxXval8O8QKdPbJm
 +bhwdzsIGC3r+FinHLRe0ATTYEZHttOY7SYdeFkvpcvwlqWE9yjR+yhBQb0C28IG1U2c17hyP
 PRLRRiYXmRd4Wh+eRmQ/HApZog1qYZ9OCuAr25bS1/F3e/vtSvsGw0wmBTdI4XBDGyEF6LUmZ
 dlBEIlKlnWFAeI4+chCFXjeVRGbWb9sH58AtdewOOHCnhpMlwrxHzUbVMcRJ2zyd3UHeWAip9
 dMK5FSH238Bo49Otb3IERxzJLHp6RI3sf/d53oR69BaDbgBLUw2Wq/1JBgR2FqZRckZlPf2yY
 ITIYl6Ly4e3BkNwMZRl2FdxBuNJxJZyLVv8+MO+ofPuHR4H5MRqDJSFnh

=E2=80=A6
> Following the code styleof the file, assigning the u16
> value to u32 variable and using it for the bit wise
> operation, thus ensuring no unintentional sign
> extension occurs.

Would you like to reconsider such a word wrapping approach
besides typo avoidance?


See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12#n94

Regards,
Markus

