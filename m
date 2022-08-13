Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D636591A16
	for <lists+linux-edac@lfdr.de>; Sat, 13 Aug 2022 14:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiHMME3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 13 Aug 2022 08:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbiHMME1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 13 Aug 2022 08:04:27 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB5A3D5B5
        for <linux-edac@vger.kernel.org>; Sat, 13 Aug 2022 05:04:23 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 14803 invoked from network); 13 Aug 2022 14:04:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1660392260; bh=wKEw7lZVGIO4FsW/4PqO6/mll0tKNRq8juBJx+E0Fwg=;
          h=Subject:To:Cc:From;
          b=Gst5pPAT9GdSraKma1eqiGvS8ryIA1J/NpSOR4wLrPi2sE0lUcUIrIlyP0SqgOigl
           oI7GvoS10rWc2YbYWDLCxLIi7NxqLw1NsRW4Du12CBUtCpuDb4bdBZ7VA0aojIQbrG
           vEzCuIEfsMeimUNVnxuf910nIrmQz/lB8EfMRvNw=
Received: from aaeq146.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.120.146])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <bp@alien8.de>; 13 Aug 2022 14:04:20 +0200
Message-ID: <e6b6f874-bde5-75f2-eb40-2b31097c6f8c@o2.pl>
Date:   Sat, 13 Aug 2022 14:04:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when
 removing threshold blocks
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mpatocka@redhat.com,
        gregkh@linuxfoundation.org
References: <20220614174346.3648305-1-yazen.ghannam@amd.com>
 <7c8e34c8-f12d-e7e4-b6bc-4867824865ea@o2.pl> <Yvd4cCW4ng2cG96p@zn.tnic>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
In-Reply-To: <Yvd4cCW4ng2cG96p@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 200af0b06ef4bf9c33a2e8e04d42a852
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 000000A [McN0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

W dniu 13.08.2022 o 12:09, Borislav Petkov pisze:
> On Fri, Aug 12, 2022 at 11:14:44PM +0200, Mateusz Jończyk wrote:
>> After these changes, the __threshold_remove_blocks() function looks
>> very similar to deallocate_threshold_blocks() function just above it.
> Yes, minus the list_del(&pos->miscj); But that can be made conditional
> with a bool arg to deallocate_threshold_blocks() and then remove
> __threshold_remove_blocks().
>
> Care to take Yazen's patch, fix it up, test it thoroughly (you should
> enable KASAN to catch any potential memory leaks) and send it?
>
> Thx.
>
I'll try, but I don't understand the code well yet, and have access to only one
old computer with an AMD CPU.

Greetings,

Mateusz,

