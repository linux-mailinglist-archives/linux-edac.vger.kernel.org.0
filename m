Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16D959F301
	for <lists+linux-edac@lfdr.de>; Wed, 24 Aug 2022 07:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiHXFOO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 Aug 2022 01:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiHXFOO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 24 Aug 2022 01:14:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3108079604;
        Tue, 23 Aug 2022 22:14:13 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27O3hXmE000574;
        Wed, 24 Aug 2022 05:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CXYNo0w3uPEvgt4eFqiz9cuSXMjy6Gw/0AwHHo84Szk=;
 b=Qdz6Ec4QEZgHXZrwEBXSNM0PxGedD9bn3sCw2EwaAogDagvSwopX2+ycfdEIxwqi1alf
 /XR3o8a+d/epFTWkhy9DIdAAHDFc/47UNqjwtIqZSJlg+5QX2j6YlH9mXbbjfYqBpJsv
 kJsm3lUdlat4gi8JAytgFRmn7EDC43I6FakAAUr4Y5YjIZk7vHTJT+fkwPDJMXvTaBRr
 v1E/mt+FQBsvY3MPkjwvp/uKT+cwtfS57IdDtfAt1FyT6zZcAZeRDc47P0Qsz7bgr3gj
 Kc2EOv2ioHSA9x/2/JZzYOyXUe+fYy3Rzqdc40XQwLjjhPxp26phE8wSETN5MD1LZNFj gg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pha0rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 05:13:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27O5DvVY017808
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 05:13:57 GMT
Received: from [10.50.48.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 23 Aug
 2022 22:13:54 -0700
Message-ID: <c96016c8-8992-6c8a-b7c1-0ab3722986e0@quicinc.com>
Date:   Wed, 24 Aug 2022 10:43:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/3] soc: qcom: llcc: Pass SoC specific EDAC register
 offsets to EDAC driver
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <bjorn.andersson@linaro.org>, <bp@alien8.de>, <mchehab@kernel.org>,
        <james.morse@arm.com>, <rric@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>
References: <20220812060602.7672-1-manivannan.sadhasivam@linaro.org>
 <20220812060602.7672-2-manivannan.sadhasivam@linaro.org>
 <396e6b2e-11d1-a11d-206a-cfd69f6cd358@quicinc.com>
 <20220823153152.GA6371@thinkpad>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220823153152.GA6371@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KPNeUD6KGXmCw592mAh4lQ_T32rJms-U
X-Proofpoint-GUID: KPNeUD6KGXmCw592mAh4lQ_T32rJms-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_02,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240022
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 8/23/2022 9:01 PM, Manivannan Sadhasivam wrote:
> On Mon, Aug 22, 2022 at 05:29:13PM +0530, Sai Prakash Ranjan wrote:
>> Hi Mani,
>>
>> On 8/12/2022 11:36 AM, Manivannan Sadhasivam wrote:
>>> The LLCC EDAC register offsets varies between each SoCs. Until now, the
>>> EDAC driver used the hardcoded register offsets. But this caused crash
>>> on SM8450 SoC where the register offsets has been changed.
>>>
>>> So to avoid this crash and also to make it easy to accomodate changes for
>>> new SoCs, let's pass the SoC specific register offsets to the EDAC driver.
>>>
>>> Currently, two set of offsets are used. One is SM8450 specific and another
>>> one is common to all SoCs.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> <snip> ...
>>
>>>    static const struct qcom_llcc_config sm8350_cfg = {
>>> @@ -309,6 +370,7 @@ static const struct qcom_llcc_config sm8350_cfg = {
>>>    	.size           = ARRAY_SIZE(sm8350_data),
>>>    	.need_llcc_cfg	= true,
>>>    	.reg_offset	= llcc_v1_2_reg_offset,
>>> +	.edac_reg	= &common_edac_reg,
>>>    };
>>>    static const struct qcom_llcc_config sm8450_cfg = {
>>> @@ -316,6 +378,7 @@ static const struct qcom_llcc_config sm8450_cfg = {
>>>    	.size           = ARRAY_SIZE(sm8450_data),
>>>    	.need_llcc_cfg	= true,
>>>    	.reg_offset	= llcc_v21_reg_offset,
>>> +	.edac_reg	= &sm8450_edac_reg,
>>>    };
>>>
>> Can we have LLCC version specific register offsets instead of SoC specific similar to reg_offset callbacks?
>> For SM8450, it would be llcc_v21_edac_reg and for others llcc_v1_2_edac_reg instead of common_edac_reg.
>> common_edac_reg is very general and is not exactly common for all, its just common for SoCs with same LLCC.
>>
> I thought about it but I was not sure if rest of the SoCs are using version
> v1.2. I know that reg_offset uses v1.2 but I was skeptical and hence used the
> SoC specific offsets.
>
> Can you confirm if rest of the SoCs are using v1.2?

LLCC versioning follows w.x.y.z format and w and y are major and minor versions based
on which the naming for reg_offsets is chosen.

Now in above reg_offsets, llcc_v1_2 is not v1.2, it means v1.0 or v2.0 where 1, 2 is a major version
and 0 is a minor version. llcc_v21 is actually v2.1 where 2 is a major and 1 is a minor version.
I know the naming is pretty bad, should probably replace llcc_v1_2 with llcc_v1_0_v2_0 and
llcc_v21 with llcc_v2_1? Note here minor version is important because SM8350 is v2.0 and uses
old reg offsets.

So coming to your query now, all other SoCs except SM8450(which uses v2.1) are using LLCC v1.0
or v2.0, so it is valid to use the same logic as reg_offsets for edac_reg.

Thanks,
Sai

> Thanks,
> Mani
>
>> Version based is more applicable as multiple SoCs might use same LLCC versions and would reduce SoC specific data
>> which would be needed for every SoC in case some newer LLCC comes out. I know you could just call sm8450_edac_reg
>> for lets say sm8550 or so on to reduce duplication but that won't look good.
>>
>>
>> Thanks,
>> Sai

