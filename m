Return-Path: <linux-edac+bounces-1189-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDCE8FD081
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 16:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2197F1C22CA3
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D18A17BCA;
	Wed,  5 Jun 2024 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IpCHjkdt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98B1755A;
	Wed,  5 Jun 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596640; cv=none; b=QC0gzkSzvT3jdJVwcjSs3tqU6TijRPTtw2EL01qme1L5ahJE3y2rfjQ8gqti4JatLd1Oqwj81CLDioe2eVGbifFm8unOjSb2KrfbnKgIz8z1nSJtDWzmIeibEyYZiUMRidXzsPsz9eBF+FxMCqTth91UXnQkHUXp+/0pp8vnWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596640; c=relaxed/simple;
	bh=DNMwsQB8F98x6tqx/Sd3jfGF8X/pT+TnKEfF4Ph/3Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hc6s+R6fstAmCLEdcK7wLdm0vSTEihkXp4zYxCHWXk6Rz99NXVJQvOvYsUAvKg5lzFcTXmnRTi4fATgYwEjObFfaT0MEoMEiLihbA6Bus4X2ID4761Lcz0H/A4G5auESsbgqvt5aWR7A6S55xYnJ02h0d/6ji3XQ/mnQAb+qo4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IpCHjkdt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455B1Mpf010904;
	Wed, 5 Jun 2024 14:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nIVqUesmc+zClgQPv4Z85quMTqlyKMrwi1D+BMYd2k0=; b=IpCHjkdtGZzK7XRe
	X44QOQr7tlRnKw0YvvMvAhO+IdB9zg9paiKj4TzMi5GMcVlZnR4XtbYJp01/fLws
	QdZ1PiJsBYPVjhoCY4QFg/KChW3ZZDn7l0iMmSJHghtL4gNCL3rJ9E1i/jb57dZi
	iheedfBXOzdupvcK1wCBAAECwG1vi97BQI4A6mSgUcFgXlqTMxpJQ24CZYX74ytt
	ZOgY9l4Zkx1f31OasVDE2XARa2LnREEEX+w9WsCKBzdECNJOXVxnpU1IS9bpVy9U
	sPfuQrwH6mcuIT10WPgBu2kjpPbBPEExrT7CfKaINU4Yn0mmDnzeyXpkcEuCJs5h
	JgjO1Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjhw0s71h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 14:10:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 455EAGrV015085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 14:10:16 GMT
Received: from [10.48.241.109] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Jun 2024
 07:10:15 -0700
Message-ID: <1d9e1530-be63-4374-b952-e12b15cee9d3@quicinc.com>
Date: Wed, 5 Jun 2024 07:10:14 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RAS/AMD/ATL: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240604-md-ras-amd-atl-v1-1-d4eb3cf3abe4@quicinc.com>
 <20240605094051.GDZmAyo1-j_uBri_YO@fat_crate.local>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240605094051.GDZmAyo1-j_uBri_YO@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X5EwgURkzbmpuGtjXlEQ4Plh2BvvSXO3
X-Proofpoint-GUID: X5EwgURkzbmpuGtjXlEQ4Plh2BvvSXO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406050107

On 6/5/2024 2:40 AM, Borislav Petkov wrote:
> Btw, I'd suggest instead of sending those piecemeal-wise, one per
> driver, just group them all by subsystem and whatnot so that each
> maintainer can pick it up and this new thing modpost decided to complain
> about, can be taken care of without noodling through each driver
> one-by-one.
> 
> Better yet: do a coccinelle patch and convert the whole tree.

I actually did use a simple script to do a conversion locally, but the hard
part is determining what text to use for the description. So my local
conversion just added:
MODULE_DESCRIPTION("TBD");

Then, on a per-directory basis, I look at documentation in the .c files and
the Kconfig to replace the TBD with an appropriate description. And I then
create patches for that directory based upon MAINTAINERS entries.

This was the only file in drivers/ras that had an issue.

In drivers/hid there were a large number of issues.
Some of the files had specific MAINTAINERS entries so I sent them separately:
https://lore.kernel.org/all/20240604-md-hid-letsketch-v1-1-ff38ae7b4cb0@quicinc.com/
https://lore.kernel.org/all/20240604-md-hid-lg-g15-v1-1-265b094db089@quicinc.com/
https://lore.kernel.org/all/20240604-md-hid-logitech-dj-v1-1-560f6b3cb54b@quicinc.com/
https://lore.kernel.org/all/20240603-md-hid-logitech-hidpp-v1-1-060f06e4529f@quicinc.com/

I then sent a large patch for all of the remaining drivers/hid patches:
https://lore.kernel.org/all/20240604-md-hid-misc-v1-1-4f9560796f3c@quicinc.com/


