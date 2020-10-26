Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C441F2998B9
	for <lists+linux-edac@lfdr.de>; Mon, 26 Oct 2020 22:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbgJZV2V (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Oct 2020 17:28:21 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:62926 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733001AbgJZV2U (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 26 Oct 2020 17:28:20 -0400
X-Greylist: delayed 2168 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 17:28:19 EDT
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 09QKjOX7020980;
        Mon, 26 Oct 2020 20:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=pA/oDG+sdQV0EXxWNNoKpVQkOMlzUTuub2403I4Dcow=;
 b=dtIa0RGeDVyPWHWFUK2eKYyQr61i2AMPLOiamJXMtcMbCKxUUxCo7j1vGHrqwM6yWzad
 12xjHuXyAOhkIcbO+hKKTzCaGDZvFBFG5GY0h87AZ6xOzAxFD519ZEzpRS+8elKmdjhq
 iYAfBhZQHIKk0QoFLKQgC5EZI+NelvTWknWlr8g2QCVo9s2ud2Dy/wzC4B6838zRz5JR
 Ud7fllRe8ykBCtaPYiIz7nWQd/yYrSVZHBnMKBp2zNFNLI7a5LtH0AzbFQc899TO70eD
 zNfFEyXVBNYZQAojuAmB6s6rw5msc02uYfMcDsFs5QQmHmUlbhu2JUpomeTx7C9ueEsu tg== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 34cceu9cd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 20:52:07 +0000
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 09QKow2Y025232;
        Mon, 26 Oct 2020 16:52:06 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint1.akamai.com with ESMTP id 34cfkxvyus-1;
        Mon, 26 Oct 2020 16:52:06 -0400
Received: from [0.0.0.0] (stag-ssh-gw01.bos01.corp.akamai.com [172.27.113.23])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 9C714239E9;
        Mon, 26 Oct 2020 20:52:06 +0000 (GMT)
Subject: Re: Constant output in syslog of EDAC message
To:     Borislav Petkov <bp@alien8.de>
Cc:     Raymond Bennett <raymond.bennett@gmail.com>,
        linux-edac@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
References: <CAKpodDyWSY+Wt5Q04o5EyjZZU4PFST8U9UNcjwrJZ6C=Tc744g@mail.gmail.com>
 <20201019205658.GI24325@zn.tnic>
 <e0fda286-d8e3-dabb-6cf5-fcd974e048b5@akamai.com>
 <20201020091940.GA11583@zn.tnic>
 <3d0f6dfa-850c-a4e1-c9fa-4b4ca1983650@akamai.com>
 <20201026181043.GF22116@zn.tnic>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <e698aaa3-2a3e-acdd-6ffe-d3275f7e7346@akamai.com>
Date:   Mon, 26 Oct 2020 16:52:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026181043.GF22116@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_14:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 phishscore=0 mlxlogscore=972 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260135
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_14:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=919 impostorscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260135
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 184.51.33.18)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 10/26/20 2:10 PM, Borislav Petkov wrote:
> Hi,
> 
> On Mon, Oct 26, 2020 at 01:47:05PM -0400, Jason Baron wrote:
>> So, we would still continue to support edac_debug_level=N but the
>> user would have additional control.
> 
> Do you have any actual users needing this? If yes, what are their use
> cases?
> 
> Because I have this aversion towards adding functionality just because
> and that it potentially might be useful and "users may want". Either
> they do and they want to use it for X or we don't do anything... yet.
> 
> In this particular example, those debug printks are just useless noise
> so off they go.
> 
> Thx.
> 

Hi Boris,

So I was motivated by this example, where if we had this facility,
we could easily say just go turn off that specific print instead of
wait for a new kernel. More generally, I think as you crank up the
verbosity there may be more of a need to customize the debug
information, but I don't have any specific use case in mind beyond
that.

I was also curious if various subsystems would find this facility
useful.

Thanks,

-Jason
