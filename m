Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16D83CC66F
	for <lists+linux-edac@lfdr.de>; Sat, 17 Jul 2021 23:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhGQVID (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 17 Jul 2021 17:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhGQVIB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 17 Jul 2021 17:08:01 -0400
X-Greylist: delayed 352 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Jul 2021 14:05:04 PDT
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256F1C061762;
        Sat, 17 Jul 2021 14:05:04 -0700 (PDT)
From:   Joshua Kinard <kumba@gentoo.org>
Subject: Re: [PATCH v2 1/3] MAINTAINERS: mark sections from Ralf Baechle
 orphan
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
Cc:     "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210625110419.24503-1-lukas.bulwahn@gmail.com>
 <20210625110419.24503-2-lukas.bulwahn@gmail.com>
 <CAKXUXMxFBaBneVZf3WCCYJ8Theu55Nf-gFe=hs5u3mMVd41mTw@mail.gmail.com>
Openpgp: preference=signencrypt
Message-ID: <c9e6753b-ce4d-fe63-1b4d-fc37cca77a3b@gentoo.org>
Date:   Sat, 17 Jul 2021 16:59:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMxFBaBneVZf3WCCYJ8Theu55Nf-gFe=hs5u3mMVd41mTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 7/17/2021 03:03, Lukas Bulwahn wrote:
> On Fri, Jun 25, 2021 at 1:04 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>>
>> The domain lookup for linux-mips.org fails for quite some time now. Hence,
>> webpages, the patchwork instance and Ralf Baechle's email there is not
>> reachable anymore.
>>
> 
> There has not been any specific comment on marking kernel parts solely
> "maintained" by Ralf Baechle as Orphan.
> 
> So, given the feedback on this overall patch set from Maciej and Kurt:
> - the domain lookup for linux-mips.org does resolve again.
> - the patchwork instance moved.
> - Ralf Baechle's email now does at least forward somewhere.
> 
> However, it still holds that:
> 
> Ralf Baechle has not been active since February 2018; so, set all
> MAINTAINERS sections with Ralf as sole maintainer to Orphan, and give
> others a chance to claim maintainership if these sections are still of
> interest.
> 
> I suggest that independent of the other patches in this patch set, I
> rework the commit message of this patch here (basically dropping the
> first sentence) and send out a final patch for this subject that
> Thomas can then pick.
> 
> Any comments or rejections to that suggestion?
> 
> Lukas


>> @@ -9654,9 +9652,8 @@ F:        Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml
>>  F:     drivers/iio/gyro/mpu3050*
>>
>>  IOC3 ETHERNET DRIVER
>> -M:     Ralf Baechle <ralf@linux-mips.org>
>>  L:     linux-mips@vger.kernel.org
>> -S:     Maintained
>> +S:     Orphan
>>  F:     drivers/net/ethernet/sgi/ioc3-eth.c

Thomas virtually re-wrote this driver, so it is probably more appropriate to
leave it as maintained, but mark him as the maintainer.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
rsa6144/5C63F4E3F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
