Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0CD5F4610
	for <lists+linux-edac@lfdr.de>; Tue,  4 Oct 2022 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJDO6u (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Oct 2022 10:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJDO6t (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Oct 2022 10:58:49 -0400
X-Greylist: delayed 2254 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Oct 2022 07:58:46 PDT
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A292A268
        for <linux-edac@vger.kernel.org>; Tue,  4 Oct 2022 07:58:45 -0700 (PDT)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.17])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1ofimx-009aVI-AG; Tue, 04 Oct 2022 15:20:52 +0100
Message-ID: <f91748e8-bec6-e19f-1b1a-dd6b0bda59cb@codethink.co.uk>
Date:   Tue, 4 Oct 2022 15:20:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 0/7] Use composable cache instead of L2 cache
Content-Language: en-GB
To:     Zong Li <zong.li@sifive.com>, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ben Dooks <ben.dooks@sifive.com>, bp@alien8.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
References: <20220913061817.22564-1-zong.li@sifive.com>
 <CANXhq0qG-aEEHxWbtRgC+RO-wC36MtPUfu+eMpX89wOtqGJL0w@mail.gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CANXhq0qG-aEEHxWbtRgC+RO-wC36MtPUfu+eMpX89wOtqGJL0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 21/09/2022 06:09, Zong Li wrote:
> On Tue, Sep 13, 2022 at 2:18 PM Zong Li <zong.li@sifive.com> wrote:
>>
>> Since composable cache may be L3 cache if private L2 cache exists, we
>> should use its original name "composable cache" to prevent confusion.
>>
>> This patchset contains the modification which is related to ccache, such
>> as DT binding and EDAC driver.
>>
>> The DT binding is based on top of Conor's patch, it has got ready for
>> merging, and it looks that it would be taken into the next few 6.0-rc
>> version. If there is any change, the next version of this series will be
>> posted as well.
>> https://lore.kernel.org/linux-riscv/20220825180417.1259360-2-mail@conchuod.ie/
>>
>> Change log in v5:
>>   - Add a patch to modify aux vector for sysconf
>>
>> Change log in v4:
>>   - Change the return value from from ENODEV to ENOENT
>>   - Apply pr_fmt refinement to all pr_err
>>
>> Change log in v3:
>>   - Merged the EDAC patch into L2 rename patch
>>   - Define the macro for register shift and refine the relative code
>>   - Fix some indent issues
>>
>> Change log in v2:
>>   - Separate the rename and diff to different patches
>>   - Rebase the dt-bindings based on Conor's modification
>>   - Include the patches of Ben for refinement of printing message
>>
>> Ben Dooks (2):
>>    soc: sifive: ccache: reduce printing on init
>>    soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes
>>
>> Greentime Hu (2):
>>    soc: sifive: ccache: Rename SiFive L2 cache to Composable cache.
>>    riscv: Add cache information in AUX vector
>>
>> Zong Li (3):
>>    dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
>>    soc: sifive: ccache: determine the cache level from dts
>>    soc: sifive: ccache: define the macro for the register shifts
>>
>>   ...five-l2-cache.yaml => sifive,ccache0.yaml} |  28 ++-
>>   arch/riscv/include/asm/elf.h                  |   4 +
>>   arch/riscv/include/uapi/asm/auxvec.h          |   4 +-
>>   drivers/edac/Kconfig                          |   2 +-
>>   drivers/edac/sifive_edac.c                    |  12 +-
>>   drivers/soc/sifive/Kconfig                    |   6 +-
>>   drivers/soc/sifive/Makefile                   |   2 +-
>>   .../{sifive_l2_cache.c => sifive_ccache.c}    | 200 ++++++++++--------
>>   .../{sifive_l2_cache.h => sifive_ccache.h}    |  16 +-
>>   9 files changed, 158 insertions(+), 116 deletions(-)
>>   rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive,ccache0.yaml} (83%)
>>   rename drivers/soc/sifive/{sifive_l2_cache.c => sifive_ccache.c} (31%)
>>   rename include/soc/sifive/{sifive_l2_cache.h => sifive_ccache.h} (12%)
>>
>> --
>> 2.17.1
>>
> 
> Hi Palmer,
> I was wondering if this series looks good to you, and could you please
> help us to take it into riscv-tree?
> Thanks.


I've given this series some basic testing, so would also like to see
this sorted out.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

