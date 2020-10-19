Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3D293070
	for <lists+linux-edac@lfdr.de>; Mon, 19 Oct 2020 23:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbgJSVZw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Oct 2020 17:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgJSVZw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Oct 2020 17:25:52 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D330C0613CE
        for <linux-edac@vger.kernel.org>; Mon, 19 Oct 2020 14:25:52 -0700 (PDT)
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09JLJS87019400;
        Mon, 19 Oct 2020 22:25:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=/QCuB0pUbisYOAw2xr7nvLUVM/azpTTeLr7nF8uZoSo=;
 b=P5K/NJrRdh9OZd9FUdVAPeGmwTD20ZtYP+QAX8JZVTkfv8ZN/ldi4D6enAz8L8kIhPt7
 8hyq76MtLqlAqfQwWFxfviEorizFCCl40fJ5hijUimz2+hCJwRphxzLQWdxazttX1htv
 BXigpj9pS7r640hXv/4a0CgJcW4IBL0A5pW7lzqowINdqlXbBHYXDLqPr/wEZsMrc+JO
 Wt6yvl94n9wSXIn44CWdZJgEQeAQcde83n6CJsJq3H7GiLKX8NYwosG4Lb3n5EhspTrS
 x/EEnlu5ARcOrWBneY+jDmtUjurQ6QnC26FlHb8Gjvggb28Imffg5wtH+Mm6KZuW+ixZ jg== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 347ng0jafh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 22:25:44 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 09JLKYw6016386;
        Mon, 19 Oct 2020 17:25:43 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint1.akamai.com with ESMTP id 347uxxnjpa-1;
        Mon, 19 Oct 2020 17:25:43 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 3830E3D532;
        Mon, 19 Oct 2020 21:25:43 +0000 (GMT)
Subject: Re: Constant output in syslog of EDAC message
To:     Borislav Petkov <bp@alien8.de>,
        Raymond Bennett <raymond.bennett@gmail.com>
Cc:     linux-edac@vger.kernel.org
References: <CAKpodDyWSY+Wt5Q04o5EyjZZU4PFST8U9UNcjwrJZ6C=Tc744g@mail.gmail.com>
 <20201019205658.GI24325@zn.tnic>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <e0fda286-d8e3-dabb-6cf5-fcd974e048b5@akamai.com>
Date:   Mon, 19 Oct 2020 17:25:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019205658.GI24325@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-19_11:2020-10-16,2020-10-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190142
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-19_11:2020-10-16,2020-10-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190142
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 184.51.33.18)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 10/19/20 4:56 PM, Borislav Petkov wrote:
> On Mon, Oct 19, 2020 at 01:37:16PM -0700, Raymond Bennett wrote:
>> Hi,
>>
>> I am seeing the constant output of the following messages in syslog,
>> wondering what I can do to resolve this:
>>
>> Oct 19 13:19:30 hostname kernel: EDAC DEBUG: ie31200_check: MC0
> Looks like a debugging leftover. I'll remove it soon unless Jason (CCed)
> screams.
>
> Leaving in the rest for him.

Hi,

Yes, I likely was just following what was in other edac drivers at

the time - for example, i3200_check() has a similar debug. I guess

it could have a higher level. But if we remove this one, we may

want to audit some of the other edac drivers as well.

Thanks,

-Jason


>   
>> It outputs about once every second.
>>
>> uname -a
>> Linux hostname 5.9.0-991.native #1 SMP Mon Oct 12 08:10:54 PDT 2020
>> x86_64 GNU/Linux
>>
>> /proc/cpuinfo
>> processor : 7
>> vendor_id : GenuineIntel
>> cpu family : 6
>> model : 158
>> model name : Intel(R) Xeon(R) CPU E3-1505M v6 @ 3.00GHz
>> stepping : 9
>> microcode : 0xd6
