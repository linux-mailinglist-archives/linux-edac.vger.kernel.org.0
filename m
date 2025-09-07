Return-Path: <linux-edac+bounces-4733-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B8FB47BB7
	for <lists+linux-edac@lfdr.de>; Sun,  7 Sep 2025 16:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DED3AFC22
	for <lists+linux-edac@lfdr.de>; Sun,  7 Sep 2025 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E0D262FED;
	Sun,  7 Sep 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TRSkEyP/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6913B2A4;
	Sun,  7 Sep 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757253623; cv=none; b=PmDmwNEkr+wwMnkLVcMPjCE9LDV9l0EQGLMqZr/wI6AH+5ROGBMjEwMc/B2+sSIPtQHP4052N3aCrBNDeKr0+J7CWEdeuO6mLeWnJbYmAnJzXXJn1Rs4FxggZlRISBD8AGHcbIqUucsUaoBgCqx/Vr3UcN4IO1mj0BVuoBnqEBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757253623; c=relaxed/simple;
	bh=MZor1fwPCfVM6axF1ohQT2yACytIqwzzwiJkt/Y2RFE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rzmp2ncizCxWJ+De4GTK/D697K5XQVoIarJ/AbOHB62I6iDY1Xxz5rvujOJhY5zA7ujOyc4nnCyNDTGvc6HkaLLgcgr9VFGrWD0OoL9aDejFvedZFsR5bgZ42eC+SSUDav8mb28JhPzTCAmOWpwyan7qCQK3cYBkD9/2DqcegOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TRSkEyP/; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757253619; x=1757858419; i=markus.elfring@web.de;
	bh=MZor1fwPCfVM6axF1ohQT2yACytIqwzzwiJkt/Y2RFE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TRSkEyP/kBZgxqEQim6984tEiL11H2f2JlhHwThZWqDo8qTURlGOh8Hs5BJAYUS5
	 UicahDbLn21+9XvuD2alJM2emk0fBF/2OEStZoJ1HsBh2BrV7HW68q/kMiEg+T2q2
	 lNbBDuNwI/5qGQo2mGs84+8+FpmjAX6aDCzwQo1y2ROe+3Ti1UfnWlct1lCR+uwNT
	 7ITDT34X/wqNawdTOyriWUZ2POHzxrhjwzCRAA/79ypdhmQBq+rcb8gU5SaZyRva7
	 S2S8TCyChbIOj1ZK/fUNxbY2BIzf/uZuaqcqdoEG0hCtd5w9tzw5MsqkIzwgGhy66
	 QCpSTpoeXzvOmrvwxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.176]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mkmzr-1uA7921ElT-00cy28; Sun, 07
 Sep 2025 16:00:19 +0200
Message-ID: <479a17f3-588d-474a-a3b7-03caafa3051e@web.de>
Date: Sun, 7 Sep 2025 16:00:16 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 linux-edac@vger.kernel.org, devicetree@vger.kernel.org, git@amd.com
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
 Conor Dooley <conor+dt@kernel.org>, James Morse <james.morse@arm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>,
 "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, Tony Luck <tony.luck@intel.com>
References: <20250826052914.2066884-2-shubhrajyoti.datta@amd.com>
Subject: Re: [PATCH v8 1/5] cdx: add the headers to include/linux
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250826052914.2066884-2-shubhrajyoti.datta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ipW2oBSdQzibGO7AnpBr3sJrk02eXfCsy492iLOzClaMv182xfA
 gKRKyMgU2dGQbKeGlIy2FlRbxMZVmD7hPy5Rbh78THhs/Os1J0x8MPiGbZ3fg9Y+e6TEG/0
 KlkmIDoz8OVZspbRDx8sK9Prpjc7jThE5ES4lLVa2hmtfF+6RMENR0dFTgGo83s2JURd2st
 ZtRWV1+bAR/VtEd0wV1Sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4G3/3R/YawU=;BzdNXZTgY66FE3Xp0QDhF8JqYje
 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

> Move `bitfield.h` from the CDX controller directory to
> `include/linux/cdx` to make them accessible to other drivers.
=E2=80=A6
> This is in preparation for VersalNET EDAC
> driver that relies on it.

Please improve the word wrapping for such a change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc4#n658

Regards,
Markus

