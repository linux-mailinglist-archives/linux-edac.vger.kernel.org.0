Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A1F61ECD3
	for <lists+linux-edac@lfdr.de>; Mon,  7 Nov 2022 09:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiKGIZN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Nov 2022 03:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiKGIZJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Nov 2022 03:25:09 -0500
Received: from mail.gromeck.de (mail.gromeck.de [188.68.46.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E1914000
        for <linux-edac@vger.kernel.org>; Mon,  7 Nov 2022 00:25:04 -0800 (PST)
Received: from trillian.site (111-128-165-046.ip-addr.inexio.net [46.165.128.111])
        by mail.gromeck.de (Postfix) with ESMTPA id 9823580154;
        Mon,  7 Nov 2022 09:25:01 +0100 (CET)
Received: from [10.0.50.1] (111-128-165-046.ip-addr.inexio.net [46.165.128.111])
        by trillian.site (Postfix) with ESMTPSA id 0F3FF20280;
        Mon,  7 Nov 2022 09:20:45 +0100 (CET)
Message-ID: <9b38a9cc-74eb-b291-216c-b2c3e2cc34a2@gromeck.de>
Date:   Mon, 7 Nov 2022 09:20:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: EDAC support for 'Rocket Lake'
Content-Language: de-DE
From:   Christian Lorenz <Christian.Lorenz@gromeck.de>
To:     "Luck, Tony" <tony.luck@intel.com>, Jason Baron <jbaron@akamai.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <1b2f0acd-c03a-9403-406e-3c7dea7b84f5@gromeck.de>
 <Yz2hEY9XFlNJudfw@agluck-desk3.sc.intel.com>
 <4718dc61-d5a6-c3a7-a30e-a09d261589fd@akamai.com>
 <SJ1PR11MB608325D0EFE4BE2E72324395FC5C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <7d76be22-ef32-b7e7-1450-ecd9ec86bdb3@gromeck.de>
In-Reply-To: <7d76be22-ef32-b7e7-1450-ecd9ec86bdb3@gromeck.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



Am 21.10.22 um 14:00 schrieb Christian Lorenz:
> 
> Am 06.10.22 um 19:03 schrieb Luck, Tony:
>>> I've really only added hardware I have access to, and we don't have
>>> 'Rocket Lake'. I'm happy to help work on support if you have a datasheet
>>> and can test. It may be as easy as adding some new pci ids for example:
>>
>> Jason,
>>
>> Some web searching hasn't turned up a public data sheet. The EDS volume 2
>> is Intel Doc # 615924. Do you have access through Akamai? If that confirms that
>> you just need to add some new PCI IDs etc. then I can get someone to make
>> it OK to post a patch.
>>
>> Testing is harder. I can probably get access to a rocket lake internally. But
>> I don't think those support ACPI error injection. So would only be able to basic
>> "does the driver load" test. Not "does it report memory errors correctly".
>>
>> -Tony
> 
> Hi,
> 
> I can try to organize a piece of HW.
> Let me know if that would help, and who and where this HW would be needed.
> I will check with our HW vendor and we will see if things can be made possible.
> 
> Christian

Hi,

as I didn't get any response, I would like to ask again.
I understood that adding/fixing the EDAC support for Rocket Lake is lacking
available HW.
Is there any demand from one of you for Rocket Lake HW?
Let me know, so that we can check with our vendor.

Thanks.

Christian
