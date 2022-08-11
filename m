Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5494D59047B
	for <lists+linux-edac@lfdr.de>; Thu, 11 Aug 2022 18:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbiHKQaD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Aug 2022 12:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbiHKQ3J (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Aug 2022 12:29:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EF5A025C;
        Thu, 11 Aug 2022 09:08:55 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B8jd85019006;
        Thu, 11 Aug 2022 16:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=I4zESqQrVJQYJZNsIBncut4tO2HEd+SfmJY2Y2sLzkY=;
 b=VupQYw4RwitCamcl2dD9c8zmTj8bqmWiRGFY/ok6yew/7hF8g8UaVyRHVt9IiEDNqeTr
 IBUQ9+nRzouLMrzuhIVE88FKaqWGA/PhQzDnTw1nmeBY0tCXuOHa/Bc8LGyqZaBsU0kd
 akNxrDZ0UQzh2wuSntoCacBGv/Pe9PpxNJIuEuHPZv4jn9s88GeZQxOKs4wy6QsuroD+
 ieg4DBguulwwqcHZLBhPsZCkms5VUP4HAmeroI7or3r8cIat8os53Ukn3kFuC25wWUX4
 8XGsJoBkmIB2RDKE7hhponzyUUoR979+ZbXVp5ocd/nEQpEMHKttP3vvXdoGlJXwukFl Rw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hvw1dhp9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 16:08:32 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27BG8Vq8023166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 16:08:31 GMT
Received: from [10.110.117.159] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 11 Aug
 2022 09:08:31 -0700
Message-ID: <343d1491-49a0-ea38-1b65-dc2bdfb4726d@quicinc.com>
Date:   Thu, 11 Aug 2022 09:08:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Borislav Petkov <bp@alien8.de>
CC:     <bjorn.andersson@linaro.org>, <mchehab@kernel.org>,
        <james.morse@arm.com>, <rric@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220811100924.79505-1-manivannan.sadhasivam@linaro.org>
 <YvTehUOIqJGqXgXY@zn.tnic> <YvTfqg0q/8kIMY91@zn.tnic>
 <20220811112032.GB29799@workstation> <YvTo8tE3DaHifrSp@zn.tnic>
 <20220811115334.GC29799@workstation> <20220811115711.GD29799@workstation>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20220811115711.GD29799@workstation>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2CPzHcJzXw_7LudSXU_HfdM360UZ6xCu
X-Proofpoint-ORIG-GUID: 2CPzHcJzXw_7LudSXU_HfdM360UZ6xCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_11,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=1 clxscore=1011 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=192 malwarescore=0 mlxscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208110054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello Mani,

On 8/11/2022 4:57 AM, Manivannan Sadhasivam wrote:
> Clipped the bouncing email addresses...
> 
> On Thu, Aug 11, 2022 at 05:23:34PM +0530, Manivannan Sadhasivam wrote:
>> On Thu, Aug 11, 2022 at 01:33:06PM +0200, Borislav Petkov wrote:
>>> On Thu, Aug 11, 2022 at 04:50:32PM +0530, Manivannan Sadhasivam wrote:
>>>> I know get_maintainer.pl :) But the problem is, Qualcomm recently
>>>> switched their email domain from codeaurora.org to quicinc.com.
>>>
>>> Great:
>>>
>>> $ git grep codeaurora.org MAINTAINERS | wc -l
>>> 5
>>>
>>
>> Yep! Most of the active developers have already changed their domains in
>> MAINTAINERS file. But the left ones are either not actively maintained
>> (yeah bad) or the maintainers have left Qualcomm.
>>
>>> ;-\
>>>
>>>> So even if I use the maintainers codeaurora domain now, they will
>>>> bounce.
>>>
>>> Hmm, so the mails I sent with codeaurora on Cc didn't bounce back - I
>>> got only the quicinc bounces. That doesn't mean that codeaurora actually
>>> gets delivered...
>>>
>>
>> Not sure why. It was supposed to bounce. But could be that Qualcomm IT
>> decided to not bounce anymore since they have got enough complaints from
>> developers ;)
>>
> 
> Okay, seems to be bouncing for me:
> 
> The response from the remote server was:
> 585 5.1.1 <ckadabi@codeaurora.org>: Recipient address rejected: undeliverable address: No such user here.
> 585 5.1.1 <vnkgutta@codeaurora.org>: Recipient address rejected: undeliverable address: No such user here.

It is ok if someone from Linaro team becomes the maintainer for this 
driver.

---Trilok Soni
