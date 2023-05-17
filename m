Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA6E705D6F
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 04:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjEQCtw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 22:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjEQCtv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 22:49:51 -0400
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C30103
        for <linux-edac@vger.kernel.org>; Tue, 16 May 2023 19:49:49 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684291788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EsjCPqdF40VbunsnjYkM84s06frJ/PE3tIX8ln1mLtg=;
        b=u/2LVRmhcj6ji42+Sypiqe+H+fGDwKhUxX5ugAbRDYH+axy3T+GMXgaXvH9omlrPL/AANS
        Xqf7jvnjHAKwQXhIf3PW1UFg6gC621lO9NmxM40leVC0L2NFOomNJhjRV4HWhpnnPekxGM
        daiQXXsVo6PLRxMqC7yZ5sVy8b2K0Yg=
Date:   Wed, 17 May 2023 02:49:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <f0a8449f4a428300a5143b6ea3a51b82@linux.dev>
Subject: Re: [PATCH] EDAC: Expose node link in sysfs if CONFIG_NUMA
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Borislav Petkov" <bp@alien8.de>
Cc:     james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <SJ1PR11MB60831CF4AC4E4C23DE362E0DFC799@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB60831CF4AC4E4C23DE362E0DFC799@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230516111942.GCZGNmzu3Abd4KmZu3@fat_crate.local>
 <20230516103403.GBZGNcG7Q1sdtUpcHW@fat_crate.local>
 <20230516080748.3155788-1-yajun.deng@linux.dev>
 <e930d9a3efd6d99d2badc7bdff713afd@linux.dev>
 <3509bcc597e37616cf45247e8f92d369@linux.dev>
 <20230516121018.GDZGNyqjm9YWQp2Of4@fat_crate.local>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

May 17, 2023 1:25 AM, "Luck, Tony" <tony.luck@intel.com> wrote:=0A=0A>>> =
If we have '/sys/devices/system/node/node0/mc0', by comparing the number=
=0A>>> of dimm and MemTotal in meminfo. It is easy to know that the dimm =
didn't=0A>>> recognized whether it belonged to this NUMA node or not.=0A>=
> =0A>> mc !=3D NUMA node.=0A> =0A> Modern systems have multiple memory c=
ontrollers per socket.=0A> On an Icelake server I see:=0A> =0A> $ cd /sys=
/devices/system/edac/mc=0A> $ ls -l=0A> total 0=0A> drwxr-xr-x. 5 root ro=
ot 0 May 16 10:13 mc0=0A> drwxr-xr-x. 3 root root 0 May 16 10:13 mc1=0A> =
drwxr-xr-x. 5 root root 0 May 16 10:13 mc2=0A> drwxr-xr-x. 3 root root 0 =
May 16 10:13 mc3=0A> drwxr-xr-x. 5 root root 0 May 16 10:13 mc4=0A> drwxr=
-xr-x. 3 root root 0 May 16 10:13 mc5=0A> drwxr-xr-x. 5 root root 0 May 1=
6 10:13 mc6=0A> drwxr-xr-x. 3 root root 0 May 16 10:13 mc7=0A> drwxr-xr-x=
. 2 root root 0 May 16 10:13 power=0A> lrwxrwxrwx. 1 root root 0 May 16 0=
3:11 subsystem -> ../../../../bus/edac=0A> -rw-r--r--. 1 root root 4096 M=
ay 16 03:11 uevent=0A> =0A> But I can figure out the socket topology with=
:=0A> =0A> $ grep . mc*/mc_name=0A> mc0/mc_name:Intel_10nm Socket#0 IMC#0=
=0A> mc1/mc_name:Intel_10nm Socket#0 IMC#1=0A> mc2/mc_name:Intel_10nm Soc=
ket#0 IMC#2=0A> mc3/mc_name:Intel_10nm Socket#0 IMC#3=0A> mc4/mc_name:Int=
el_10nm Socket#1 IMC#0=0A> mc5/mc_name:Intel_10nm Socket#1 IMC#1=0A> mc6/=
mc_name:Intel_10nm Socket#1 IMC#2=0A> mc7/mc_name:Intel_10nm Socket#1 IMC=
#3=0A> =0A> I think this should help connect "mc*" to which node=0A> they=
 belong to.=0A> =0A=0AThanks! =0AYes, mc_name may show the NUMA id, it de=
pends on the vendor edac modules.=0A=0AOn the other hand, this directory =
'/sys/devices/system/node/node0/' should=0Ashow all resources that belong=
 to it. It already has cpu and memory symbolic=0Alink. Memory controller =
also belongs to one NUMA. The memory controller=0Asymbolic link should ap=
pear under node* directory.=0A=0A> -Tony
