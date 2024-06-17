Return-Path: <linux-edac+bounces-1299-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095CA90A1E1
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2024 03:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225DC1C20F8D
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2024 01:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A23156652;
	Mon, 17 Jun 2024 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gqLtV3Dx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9777819BC6;
	Mon, 17 Jun 2024 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588657; cv=none; b=NAOx366KWGtCt93XPfiffrjVnTuEuRXYuhNvC1zOrtFQAml3T+vV5um0IrHtwXsB0ULdfK78zyDqTeNCN9XwjJbfsPADiY9jxrHBXLCtFi/GJdcGj71BrbR2oLAGo5ftgj1Mh0AI32xQiW6Y9iJ9CA1NQ9iAe1zeI+EfTVsW35A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588657; c=relaxed/simple;
	bh=Ue0EB9ia/yrAN0YyauzTV7SY5oDbw16XaSNxoKWFz4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jobh89szzT06qRh7uvVVP32XnN3xxb4L6C/WUc5gXGu8liV7hoqMMSsuN91+lnC5BCtJsgS5alD368EIE5M9py/eaZGhtGnrOVikoAGuQW32YNPdCUJDzmqxPbYcyD5UCcfnCcIe3XpzfmLu8kcmy8S60bIlDf8qfiCOV5oS+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gqLtV3Dx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45GNsSEs027697;
	Mon, 17 Jun 2024 01:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Njs1C3lkrQ5RjLAZ0/KROR0CPFhdqk2ns0RTeOfPXE=; b=gqLtV3Dx9ytiNAaD
	n5oelLmpSLrwPwDtbD9pieR9n2Fj8ifDqHnfVHxLEdFuVNPJqJvQZ0abBSJxMW5W
	WHd6aqOQkPmQ0LFmXz8tTpHny4CWZQ4zh/SQQtpPyeYIAVA03fRupj6vmE8gCBbt
	O2jnU/k+GhmCONsFFP9FbLf5n3A9VFfAj8+96dy6eqtgN78DgI33dQO9N508G1wh
	0Q+yhqUpBkYsu7GFMq8aOkxYZUKwSsSfYPvt7bR9cQVuE5+2qDzwYS4RCnICI6pq
	tdGOmB5W+DsaeLUzGHwLsZTyPYuFUfDnxOTZY7QfmUULFe0EPLJG8TeUs/OxNLNP
	lnUclg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ysv5xgwkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 01:44:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45H1i0a0015536
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 01:44:00 GMT
Received: from [10.48.243.231] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 16 Jun
 2024 18:43:59 -0700
Message-ID: <28c653ab-af12-4857-8a32-9ea73740959a@quicinc.com>
Date: Sun, 16 Jun 2024 18:43:58 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC: layerscape: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        Mauro
 Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240613-md-arm64-drivers-edac-v1-1-149a4f0f61bb@quicinc.com>
 <20240616154347.GCZm8IMxshO8YYTTjB@fat_crate.local>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240616154347.GCZm8IMxshO8YYTTjB@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DInqufhmA_jVtANYx6VKQbmISrhM5LUE
X-Proofpoint-ORIG-GUID: DInqufhmA_jVtANYx6VKQbmISrhM5LUE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_01,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406170012

On 6/16/2024 8:43 AM, Borislav Petkov wrote:
> On Thu, Jun 13, 2024 at 02:36:21PM -0700, Jeff Johnson wrote:
>> With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/edac/layerscape_edac_mod.o
>>
>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>  drivers/edac/layerscape_edac.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/edac/layerscape_edac.c b/drivers/edac/layerscape_edac.c
>> index d2f895033280..b70d5d258fcb 100644
>> --- a/drivers/edac/layerscape_edac.c
>> +++ b/drivers/edac/layerscape_edac.c
>> @@ -69,6 +69,7 @@ static void __exit fsl_ddr_mc_exit(void)
>>  
>>  module_exit(fsl_ddr_mc_exit);
>>  
>> +MODULE_DESCRIPTION("Freescale Layerscape EDAC module");
>>  MODULE_LICENSE("GPL");
>>  MODULE_AUTHOR("NXP Semiconductor");
>>  module_param(edac_op_state, int, 0444);
>>
>> ---
> 
> $ git grep -E "MODULE_(DESCRIPTION|LICENSE)" drivers/edac/
> 
> I'd expect to see regular pairs like this:
> 
> drivers/edac/al_mc_edac.c:348:MODULE_LICENSE("GPL v2");
> drivers/edac/al_mc_edac.c:350:MODULE_DESCRIPTION("Amazon's Annapurna Lab's Memory Controller EDAC Driver");
> 
> drivers/edac/altera_edac.c:2216:MODULE_DESCRIPTION("EDAC Driver for Altera Memories");
> 
> drivers/edac/amd64_edac.c:4238:MODULE_LICENSE("GPL");
> drivers/edac/amd64_edac.c:4240:MODULE_DESCRIPTION("MC support for AMD64 memory controllers");
> ...
> 
> but there are cases which need fixing.
> 
> How about you do them all with one patch?

My process has been, for the most part, to first fix the ones where I actually
observe the warning, unless there is just one or two others. For drivers/edac
there are more than a couple more that have a LICENSE but not a DESCRIPTION:
drivers/edac/mpc85xx_edac.c
drivers/edac/octeon_edac-l2c.c
drivers/edac/octeon_edac-lmc.c
drivers/edac/octeon_edac-pc.c
drivers/edac/octeon_edac-pci.c

So my preference is to first fix the one where I actually observed the
warning, and then later fix the ones which currently don't seem to produce a
warning. But a can make an exception and fix all of them in drivers/edac.

Also note I haven't even considered doing anything for the ones that have a
DESCRIPTION but not a LICENSE such as drivers/edac/altera_edac.c. Note that a
missing LICENSE would result in a build failure, not just a warning, so the
appropriate thing to do in that case is probably to remove the DESCRIPTION. It
has been enough of a job to fix the missing DESCRIPTIONs that actually
generate warnings (I've been making changes tree-wide for over a month,
touching almost 800 files). So I prefer to let others worry about removing
DESCRIPTION/LICENSE found in files that cannot be built as modules.

/jeff


