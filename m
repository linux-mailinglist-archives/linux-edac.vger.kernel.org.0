Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3155F545B
	for <lists+linux-edac@lfdr.de>; Wed,  5 Oct 2022 14:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJEMWq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Oct 2022 08:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJEMWq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Oct 2022 08:22:46 -0400
X-Greylist: delayed 461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Oct 2022 05:22:45 PDT
Received: from mail.gromeck.de (mail.gromeck.de [188.68.46.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14954520A3
        for <linux-edac@vger.kernel.org>; Wed,  5 Oct 2022 05:22:44 -0700 (PDT)
Received: from trillian.site (030-179-165-046.ip-addr.inexio.net [46.165.179.30])
        by mail.gromeck.de (Postfix) with ESMTPA id A54298006C;
        Wed,  5 Oct 2022 14:15:01 +0200 (CEST)
Received: from [10.0.50.1] (030-179-165-046.ip-addr.inexio.net [46.165.179.30])
        by trillian.site (Postfix) with ESMTPSA id E1CCF2026C;
        Wed,  5 Oct 2022 14:13:13 +0200 (CEST)
Message-ID: <1b2f0acd-c03a-9403-406e-3c7dea7b84f5@gromeck.de>
Date:   Wed, 5 Oct 2022 14:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Christian Lorenz <Christian.Lorenz@gromeck.de>
Subject: EDAC support for 'Rocket Lake'
To:     linux-edac@vger.kernel.org
Content-Language: de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

we are using the EDAC interface on Linux for our internal ECC DIMM
hardware monitoring.

With Sky Lake CPUs, the kernel driver in use is 'skx_edac'.

We have now received servers with the following CPUs, for which there
does not seem to be kernel EDAC support:

   processor       : 11
   vendor_id       : GenuineIntel
   cpu family      : 6
   model           : 167
   model name      : Intel(R) Xeon(R) E-2386G CPU @ 3.50GHz
   external link   : see [1] at the end of this mail

We have observed that there seems to be no EDAC support for this CPU,
/sys/devices/system/edac is not populated, tools like edac-utils or
rasdaemon do not function without it.

We have tested this with the same result on:

   - RHEL 8.6 -- kernel version 4.18.0-372
   - AlmaLinux 8.6 -- kernel version 4.18.0-372
   - RHEL 9.0 -- kernel version 5.14.0

According to documentation, the E-2386G codename is 'formerly Rocket Lake'.

Our question: Is there or will there be EDAC support for this 'Rocket Lake'
Xeon E-23XX CPU?

Thank you,
Christian


[1] 
https://ark.intel.com/content/www/us/en/ark/products/214806/intel-xeon-e2386g-processor-12m-cache-3-50-ghz.html
