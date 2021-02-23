Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D652E3227AA
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 10:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhBWJTA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Feb 2021 04:19:00 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:12108 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhBWJS5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Feb 2021 04:18:57 -0500
X-AuditID: 0a580157-f39ff7000005df43-ec-6034c2174ffa
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id BB.C5.57155.712C4306; Tue, 23 Feb 2021 16:51:35 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 23 Feb
 2021 17:18:09 +0800
Date:   Tue, 23 Feb 2021 17:18:09 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft.com>
Subject: Re: [PATCH v2] Dump cper error table in mce_panic
Message-ID: <20210223171809.7df62b08@alex-virtual-machine>
In-Reply-To: <e9645a3ff93e46d4aabdf7dd45bfc4d7@intel.com>
References: <20201104065057.40442-1-yaoaili126@163.com>
        <20201117175804.39bbbdc3.yaoaili@kingsoft.com>
        <20201118124538.GI7472@zn.tnic>
        <20201119134057.37ca2c19.yaoaili@kingsoft.com>
        <20201119174508.GE3769@zn.tnic>
        <20201120172235.620eb826.yaoaili@kingsoft.com>
        <20201120102422.GA712@zn.tnic>
        <20210128200128.6f022993.yaoaili@kingsoft.com>
        <e9645a3ff93e46d4aabdf7dd45bfc4d7@intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXCFcGooCt+yCTB4McPLovPG/6xWdzft5zJ
        YufDt2wWy/f1M1pcONXAZHHm9CVWizcX7rE4sHt8b+1j8Vgzbw2jx+I9L5k8Nq3qZPPYcrWd
        xePzJrkAtigum5TUnMyy1CJ9uwSujLUH4woecFbcPLqLrYHxAnsXIyeHhICJxPem80xdjFwc
        QgLTmSR+rJzIDuG8YpS4NXUeaxcjBweLgKrE5X8JIA1sQOaue7NYQWwRATWJS4sfMIPUMwu8
        YJLY/qyDCSQhLGAl8XTDGxYQmxfI/nm3D6yBU8BSYu7PS2A1QgL9zBJXfjOD2PwCYhK9V/4z
        QVxkL9G2ZREjRK+gxMmZT8DmMAvoSJxYdYwZwpaX2P52DjPEHEWJw0t+QX2jJHGkewYbhB0r
        sWzeK9YJjMKzkIyahWTULCSjFjAyr2JkKc5NN9zECImK8B2M85o+6h1iZOJgPMQowcGsJMLL
        dtcoQYg3JbGyKrUoP76oNCe1+BCjNAeLkjhv4DaTBCGB9MSS1OzU1ILUIpgsEwenVAPTnKXx
        /Y84LGrTJSbMevQ4e/GKiOoQ61cO+2OuZqsY2iSa3Dv8Uzh96eMz0+w724/vSv8odMlA5ECK
        2NlXXnEHpp90Vtda83PPn1NOZcoqrzd21Yvm7G3sMVHZWyH/c6VqYP6a2VXOT2bsfrZ9c4Zd
        azLj5sMawgeazBOXVjHFNQmyin608p9Rd/z6+33NZXOenYic/NgzbGldy+XbOz46+O01+Ttv
        8esjH+X+2UixdV8tnfiKLc5eNlSr2fFL4vZi7gf/Hf+nT9RNrUlNv/1MXPaVoOe00ncr72g9
        WSw9cWJ2dWrRzfzqv25566TFZ3Oqmh+f/0157kwmubLDhxf5vTB6xNLwTs2ptveRCHuCEktx
        RqKhFnNRcSIAVleiPPkCAAA=
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 28 Jan 2021 17:22:30 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> 
> Getting a full memory dump after a machine check generally isn't
> all that useful anyway. The problem was (almost certainly) h/w, so
> not much benefit in decoding the dump to find which code was running
> when the h/w signalled.

The purpose I try to collect the coredump log is not to identify what the backtrace
is, I want to confirm if this panic is really needed, there are too many panics in production
environment with MCA Recovery Enabled, and no kernel log is collected, in some way we can't find
the benifits from MCA recovery, And for purley this feature cost too much.

And the unexpected NMI for fatal memory error is not the right way to get work done.
This is not right, and shouldn't happen.

> A second bite at getting the error logs from the death of the first
> kernel is worth it though.

I am not smart enough to get the point. I have paid a lot of time for this patch, 
I need an result even it doesn't work. so i like the reply like this:

1. this patch is meaningless, and should be rejected.   
2. this issue is real, but we need other methond, not this patch.
3. the patch need to improve.


Thanks
Aili Yao
