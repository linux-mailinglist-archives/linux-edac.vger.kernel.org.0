Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE4E289B1E
	for <lists+linux-edac@lfdr.de>; Mon, 12 Aug 2019 12:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfHLKPl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Aug 2019 06:15:41 -0400
Received: from sonic315-15.consmr.mail.bf2.yahoo.com ([74.6.134.125]:37437
        "EHLO sonic315-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727738AbfHLKPk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 12 Aug 2019 06:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565604939; bh=tPdyM4f7Tq8kspt5syr9wxbiHLUxanV8lkCr2Pkkkas=; h=Date:From:Reply-To:Subject:From:Subject; b=EXujxIZQM3gbLSH5laqqNzMAaTxDbnnU/a8WaGtyhBvtaiB8HaPNNziW6L6nWOule+p+sPiAp2d/qwgwV4LFB1UdU8L87Y0t+8/DdXOf1VE4V2ilCT7rhtOR8vVcDJ7vA5D3NjiPJ1zVW6Wh0TmuHBYmzgt2HDWyb1BPXI1UlnO8jJunBf/BuNpQQjpiBwW3do2vaW7BRDk1JgS4HBket9/GYpJrGJiQ29aJDPMTARP0gTHknSNIT6SMOFBFNXo2H4pHHR6J8NkAEuZiNW7jwSLO/Bi5hxDSgEsjqFRQcBZ5xELgDYMqsSbec1BuM88uw14X1+DymH8L9BZSBR9rlQ==
X-YMail-OSG: 7l55mJYVM1mC2fL_k.BG2wggnARqIXH9lSOBvS4RCDdpOrcqL2u6wKmmtlkbYe3
 8zG96a75I02RodMscBgOu3MBUz_4ixpAVSpc2H3PNTbUveMdV7xcPfb.ZtvX88EtUEF1xZ3RBmEy
 MQ.GeUrjJ6GfY4gD0Jd11H2W1Ok761VfVGBpijJ17AWnAvuuGiwZ1tFaid.7k4RXxrI5rEliuq1C
 uDXZpHAwlPO.gercT8LGsq7k46hEXElJJzmKwnVxkHHvl0t2ANl79PIIRZoSwO_3Y.slmw6wM5ww
 QXWRohBGAtfGz3cnfkqNZw8NDvYS8n6swU0XCgcRhgL_X.h0Y9LqcYrEiCEoAFGp6EfWDPsaA4Qe
 vk9wII4nZefI0IBw_scf3MOarvSarlN6b9QH7Vd08xHWEjw7nMR6yV99.SZHmAn6UBvKlTAvo3Dc
 o1y7ujFj2Kbe7s8MMP5lMcyOpMHdDp3fsMfZZo858vk.9sqzQORZb5hsEt0.Ai7Xt36uXWXh5SMA
 UPFvgB6ZmV2t1VC9lGZpAQS8x95gBefAWryx41Ag_g6nDLauepmhhGMOgGwEWbQQdKzTUz6kRvN5
 fMEAIQHTkyRrIJFLCrgaTdYBUDR8mgHew2q9J2IcSf0Yi8KZG6nBLaLZNahu9mfEVoMOe6pLMWAm
 pZu4SkkCCYZ7Ut4NjtdSvfdopa_eIavaGHBs70nNy4kHbLhl9QFyVGtICDEBwbsh6KyG5cjbMsdB
 sKGzSi8adWhTyiPYl1aG.8yY5nOviXx6P4.qkqZgoeSGVqMkQ8rh0ZJbfLozvdkswJmMmIiV0v9g
 zLBllY1Lx4Fq9J8Yc3WZ4fnjdPVHstfbq6JsFYGQRiOuR71tizd5qArKinnwSMHnnrqTCVqvQogV
 5F.XjVbNQMMNiDdYVrcjeBFkgvFroyvcGOvgd.S6zvCG4ASmgPCf_zEfKCapjlUGW7.i0KytoskO
 969PwbbjcLBIoFyq6PmxKs2QSpydsIkeBMf8d_t76y.kHnOUwCztQ_t1S0i2nF6Zg8_2ZyOUKNT.
 0Pp4UhRgGQfD1SEh7uxIKrM66NDyY_RdYP04rnUT3.KR3QtBV6o45i_6GjF2XyE_vPNR3yEi6wn_
 Bq2srbJkHoHhknI7K2.DEioScd4Xotzn9sgMkfvWoHyKSXpxzBVpGJN5QyvTefwqFUGk5ea43nUO
 OKnQ6XFUrwYyV69yp7OFx7b9vU2qb1VRqIEZUcdj7VnF5LMBwyzwI_Cp636dvQKmw6zGw_Diy9bU
 2d0GJtKgb0A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Mon, 12 Aug 2019 10:15:39 +0000
Date:   Mon, 12 Aug 2019 10:15:35 +0000 (UTC)
From:   Aisha Gaddafi <gaddafi661@gmail.com>
Reply-To: gaisha983@gmail.com
Message-ID: <300712006.2989078.1565604935757@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaisha983@gmail.com)
