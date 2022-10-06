Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B515F6ADD
	for <lists+linux-edac@lfdr.de>; Thu,  6 Oct 2022 17:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJFPmX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Oct 2022 11:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiJFPmW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Oct 2022 11:42:22 -0400
X-Greylist: delayed 718 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Oct 2022 08:42:20 PDT
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0EB13CD9
        for <linux-edac@vger.kernel.org>; Thu,  6 Oct 2022 08:42:19 -0700 (PDT)
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
        by m0050096.ppops.net-00190b01. (8.17.1.5/8.17.1.5) with ESMTP id 296CU81M016426;
        Thu, 6 Oct 2022 16:29:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=qU0ibLv7YeMyO3Mk/gP04YyeBfG1127fR6lgxghQsIk=;
 b=E6IMhURh6uzH3aRtnfm2RnONDPbh6+A3H1FnoBuqGKbHcqzHiW5rGRiliAGKFeycng8R
 tZ6D98CguYgGozKu8/acVjn21cpyu5Liyx6ahuI/Y/oNlNw+axI2Q0GnUaZ9KrxM2zji
 OqA4IoCGV+M2yzACboSHeXep6xGA08IAu9lVdYS9+Mb9W7TvC0zDACS29z7xrIImvFNp
 WP5qA7bBHbZTGoAOLfBzrhIQpXmv555pSie8NcirHPsEB9dbdGIrYEXwGE7XPl8G3v5D
 +aDjSqOhHja3vAXwDC71OjNQERQSYwxElcHBSZ3VbFtPhZhsWNbcghzRFt4op382uiX7 Jg== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 3k0j0vn91r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 16:29:55 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.17.1.5/8.17.1.5) with ESMTP id 296EjQlN030763;
        Thu, 6 Oct 2022 11:29:06 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 3jxgvy18yw-1;
        Thu, 06 Oct 2022 11:29:06 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id A55A352857;
        Thu,  6 Oct 2022 15:29:06 +0000 (GMT)
Message-ID: <4718dc61-d5a6-c3a7-a30e-a09d261589fd@akamai.com>
Date:   Thu, 6 Oct 2022 11:29:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: EDAC support for 'Rocket Lake'
To:     Tony Luck <tony.luck@intel.com>,
        Christian Lorenz <Christian.Lorenz@gromeck.de>
Cc:     linux-edac@vger.kernel.org
References: <1b2f0acd-c03a-9403-406e-3c7dea7b84f5@gromeck.de>
 <Yz2hEY9XFlNJudfw@agluck-desk3.sc.intel.com>
Content-Language: en-US
From:   Jason Baron <jbaron@akamai.com>
In-Reply-To: <Yz2hEY9XFlNJudfw@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_03,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=683 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060088
X-Proofpoint-ORIG-GUID: 9YxYV-m3DlIsFbLcBDoTTrI1gmuzrS93
X-Proofpoint-GUID: 9YxYV-m3DlIsFbLcBDoTTrI1gmuzrS93
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_04,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=650 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060089
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 10/5/22 11:21, Tony Luck wrote:
> On Wed, Oct 05, 2022 at 02:13:13PM +0200, Christian Lorenz wrote:
>> Hi,
>>
>> we are using the EDAC interface on Linux for our internal ECC DIMM
>> hardware monitoring.
>>
>> With Sky Lake CPUs, the kernel driver in use is 'skx_edac'.
>>
>> We have now received servers with the following CPUs, for which there
>> does not seem to be kernel EDAC support:
>>
>>   processor       : 11
>>   vendor_id       : GenuineIntel
>>   cpu family      : 6
>>   model           : 167
>>   model name      : Intel(R) Xeon(R) E-2386G CPU @ 3.50GHz
>>   external link   : see [1] at the end of this mail
>>
>> We have observed that there seems to be no EDAC support for this CPU,
>> /sys/devices/system/edac is not populated, tools like edac-utils or
>> rasdaemon do not function without it.
>>
>> We have tested this with the same result on:
>>
>>   - RHEL 8.6 -- kernel version 4.18.0-372
>>   - AlmaLinux 8.6 -- kernel version 4.18.0-372
>>   - RHEL 9.0 -- kernel version 5.14.0
>>
>> According to documentation, the E-2386G codename is 'formerly Rocket Lake'.
>>
>> Our question: Is there or will there be EDAC support for this 'Rocket Lake'
>> Xeon E-23XX CPU?
> 
> Christian,
> 
> Historically Intel has provided EDAC drivers for the "big" Xeon
> systems (formery "-E5" and "-E7", currently "-SP" Xeon models).
> 
> Support for the Xeon-E3 models had been provided by members of
> the community. Most recent update for the ie31200_edac driver
> to support Kaby Lake was from Jason Baron (added to this e-mail).
> 
> Jason: Are you looking at Rocket Lake?
> 

Hi,

I've really only added hardware I have access to, and we don't have
'Rocket Lake'. I'm happy to help work on support if you have a datasheet
and can test. It may be as easy as adding some new pci ids for example:

7a14a11f93df EDAC/ie31200: Add Skylake-S support

Thanks,

-Jason

