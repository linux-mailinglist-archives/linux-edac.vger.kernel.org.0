Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BB36E3388
	for <lists+linux-edac@lfdr.de>; Sat, 15 Apr 2023 22:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDOU3m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 15 Apr 2023 16:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDOU3l (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 15 Apr 2023 16:29:41 -0400
X-Greylist: delayed 501 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Apr 2023 13:29:38 PDT
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D591E1BCA
        for <linux-edac@vger.kernel.org>; Sat, 15 Apr 2023 13:29:38 -0700 (PDT)
Message-ID: <b14a8fd2-4c11-1d76-f27d-e9d10c94ca9d@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1681590070;
        bh=Ktj9egby/5Ek+E3eu87dOH7Oln7ZltNgsI3Fu2LwgPE=;
        h=Date:To:From:Subject;
        b=hvIHs8s0nwYApo4ari+PB4wN/4HCsbk2bQOEcFenAca2nan9UmMrMBc3KfO8sZdGH
         P5gF+B/8imHb+QAI4CaxXkEQtR0/nl+XZ/8oEeDSWZbaL2G2CCJ6z1q4XNKXb3/0ER
         K6P1618Q9WfaOjtOci8D6J/sQ4NAfrVgtlcJzWGU=
Date:   Sat, 15 Apr 2023 22:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     linux-edac@vger.kernel.org
Content-Language: en-US
From:   Alexander Wetzel <alexander@wetzel-home.de>
Subject: ECC DDR5 ram with i9-12950HX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello,

I've problems getting ECC ram working in a Thinkpad P16.

The processor is a i9-12950HX with ECC ram but at least a 6.2.11 kernel 
is not detecting the memory controller:

# edac-util
edac-util: Error: No memory controller data found.

The only reference to edac on kernel boot is that here:
[    1.237414] EDAC MC: Ver: 3.0.0

For my understanding this here looks like the memory controller:
0000:00:14.2 RAM memory: Intel Corporation Alder Lake-S PCH Shared SRAM 
(rev 11)

But there is no driver for the device (8086:7aa7) in 6.2.11 I can find.
I was assuming that igen6_edac is supporting Alder Lake CPUs but even 
when loaded manually it's not working...

Is there a way to get ECC working with linux? Are there any patches I 
could apply?

Alexander






