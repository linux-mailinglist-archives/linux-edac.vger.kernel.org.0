Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707C223E38B
	for <lists+linux-edac@lfdr.de>; Thu,  6 Aug 2020 23:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHFVgC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Aug 2020 17:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHFVgC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Aug 2020 17:36:02 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95EBC061574;
        Thu,  6 Aug 2020 14:36:01 -0700 (PDT)
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 076LVj4q014141;
        Thu, 6 Aug 2020 22:35:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=azshYd0pHCk8dReFdGomM7o853dL4ZDr0WCH5ADVLMs=;
 b=RpknhIAa5+UdGSlXrs5ss2ApYQLet5mbwjeBAwX5fDQFwZ//rKnP9fm6hPCUWqTdN64C
 qf+TY1p8gNTiCBG9rsWUHSHC+CKggC3sKXyVGWtn7M6X6pCvhDtmGYQ6EwH7BwFQpI8W
 oHRaj47wWWMQZT7s+6PtnhlT7zzAk3uBptC/1C58v7mwI2E2wQpg6cpmfm/gmI5rEAU6
 9a7v/EbWcOkWGJv6AMyH3mtAr++KqfOsVb9Czwijxdpgiy5qP3U9ge9bgr0yhg5D1Bir
 LapvKOwEnW9ygYE2oXbIYnKt3WBaauJlfDMJnUmXu68iImLM+p/0RmxHf+z955Y2qGka 3A== 
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 32n6yq8jmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 22:35:51 +0100
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
        by prod-mail-ppoint8.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 076LUnWC005806;
        Thu, 6 Aug 2020 17:35:50 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint8.akamai.com with ESMTP id 32n3qya7dk-1;
        Thu, 06 Aug 2020 17:35:50 -0400
Received: from [0.0.0.0] (stag-ssh-gw01.bos01.corp.akamai.com [172.27.113.23])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 0A051601B0;
        Thu,  6 Aug 2020 21:35:49 +0000 (GMT)
Subject: Re: [PATCH] EDAC/ie31200: fallback if host bridge device is already
 initialized
From:   Jason Baron <jbaron@akamai.com>
To:     bp@suse.de
Cc:     "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
References: <1594923911-10885-1-git-send-email-jbaron@akamai.com>
 <20200716185242.GA7045@agluck-desk2.amr.corp.intel.com>
 <dd7ee3d5-0a4c-adcc-ffc3-8e9b8b335683@akamai.com>
Message-ID: <3559de79-da8f-5100-f62d-938cbd68ea82@akamai.com>
Date:   Thu, 6 Aug 2020 17:35:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dd7ee3d5-0a4c-adcc-ffc3-8e9b8b335683@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_17:2020-08-06,2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=1 mlxlogscore=803 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008060140
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_17:2020-08-06,2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxscore=0 clxscore=1015
 mlxlogscore=762 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008060141
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 7/16/20 4:33 PM, Jason Baron wrote:
> 
> 
> On 7/16/20 2:52 PM, Luck, Tony wrote:
>> On Thu, Jul 16, 2020 at 02:25:11PM -0400, Jason Baron wrote:
>>> The Intel uncore driver may claim some of the pci ids from ie31200 which
>>> means that the ie31200 edac driver will not initialize them as part of
>>> pci_register_driver().
>>>

Hi,

I just wondering if there is any feedback on this issue, without this
patch the ie31200 edac driver doesn't load properly on a number of boxes.

Thanks,

-Jason
