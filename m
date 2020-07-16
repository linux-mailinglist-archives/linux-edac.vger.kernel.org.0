Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9171222CEB
	for <lists+linux-edac@lfdr.de>; Thu, 16 Jul 2020 22:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgGPUfA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Jul 2020 16:35:00 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:22046 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbgGPUfA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Jul 2020 16:35:00 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GKR9XC013965;
        Thu, 16 Jul 2020 21:33:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=Da6dgcCq+0C/jBeskEXzd4AX0zC5zU6hWo2L+Jmi3aE=;
 b=GNBROYSr3YNTCy6AHYt+1Ie/JgrlzciAwAaPjcbmJjZIMqPTl1L3MJi+0JN85J4+Fhin
 T5fwRFmZHyFy9K+pZpSfLPMDeDbM3VyiUwK3b5R4dNXmzOqDsKcOABLKoXPhfqK8m1ge
 +NI7/EVzAlnatxax++kHCm320ZGQts5FBsf31CXr37boU2TsL/zuf2hbDe2lCaMaymZk
 ZwbeWUiqIzaGHHUBLaKuYCy5jM6aZOqEcMKhiPEmodPaA5LoQo7t6IIQ0Hrb0UNKBFh6
 EaAnEAB7FlzCyMxf9LKsixlwD947Texi0vtciRoNRiGlCSz1O7clnCV7x+MtTG4RqfmH EQ== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 327ankq4ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 21:33:55 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 06GK1pfj010786;
        Thu, 16 Jul 2020 16:33:53 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint2.akamai.com with ESMTP id 3278rxf84t-1;
        Thu, 16 Jul 2020 16:33:53 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id BA79860208;
        Thu, 16 Jul 2020 20:33:52 +0000 (GMT)
Subject: Re: [PATCH] EDAC/ie31200: fallback if host bridge device is already
 initialized
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     bp@suse.de, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
References: <1594923911-10885-1-git-send-email-jbaron@akamai.com>
 <20200716185242.GA7045@agluck-desk2.amr.corp.intel.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <dd7ee3d5-0a4c-adcc-ffc3-8e9b8b335683@akamai.com>
Date:   Thu, 16 Jul 2020 16:33:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716185242.GA7045@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_08:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160135
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_08:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160139
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 7/16/20 2:52 PM, Luck, Tony wrote:
> On Thu, Jul 16, 2020 at 02:25:11PM -0400, Jason Baron wrote:
>> The Intel uncore driver may claim some of the pci ids from ie31200 which
>> means that the ie31200 edac driver will not initialize them as part of
>> pci_register_driver().
>>
>> Let's add a fallback for this case to 'pci_get_device()' to get a
>> reference on the device such that it can still be configured. This is
>> similar in approach to other edac drivers.
> 
> What functionality is lost when this happens?

There is no difference in functionality when the fallback occurs. It should
operate in the same it does when the uncore driver is not loaded.

> 
> Does the user see some message in the console
> log to let them know?

I don't think its needed as there should be no user-visible difference.

Thanks,

-Jason
