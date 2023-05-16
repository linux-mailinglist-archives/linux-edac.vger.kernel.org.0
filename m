Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35A7704D4F
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 14:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjEPME4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 08:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjEPMEv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 08:04:51 -0400
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 05:04:44 PDT
Received: from out-38.mta1.migadu.com (out-38.mta1.migadu.com [95.215.58.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2374FA
        for <linux-edac@vger.kernel.org>; Tue, 16 May 2023 05:04:44 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684238348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jRV1ViOpzqxkVyiCLlSRC9tI06roYlefHztOsLPXL50=;
        b=lrZ2Q30He1XnN3c3wOP5ouKIUfW81tFWwLMuvdvD0IfjzmhTbdLuErQQTe4LTJFkAVXzs9
        MdLIS4U7V6e42RUbv+xh3LG7gUzRHdtJnBIW8PRpVAeifr53mB9dF20IpxXWlFFAchRV8m
        RAPtu89RPBkfSveMRcf05KB3osI0v/Q=
Date:   Tue, 16 May 2023 11:59:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <3509bcc597e37616cf45247e8f92d369@linux.dev>
Subject: Re: [PATCH] EDAC: Expose node link in sysfs if CONFIG_NUMA
To:     "Borislav Petkov" <bp@alien8.de>
Cc:     tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20230516111942.GCZGNmzu3Abd4KmZu3@fat_crate.local>
References: <20230516111942.GCZGNmzu3Abd4KmZu3@fat_crate.local>
 <20230516103403.GBZGNcG7Q1sdtUpcHW@fat_crate.local>
 <20230516080748.3155788-1-yajun.deng@linux.dev>
 <e930d9a3efd6d99d2badc7bdff713afd@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

May 16, 2023 7:19 PM, "Borislav Petkov" <bp@alien8.de> wrote:=0A=0A> On T=
ue, May 16, 2023 at 11:07:11AM +0000, Yajun Deng wrote:=0A> =0A>> It will=
 help users to confirm which MC belongs to which node if there=0A>> are m=
ultiple MCs. Therefore, we can also know how many dimm on each=0A>> node.=
=0A> =0A> There are physical nodes, logical nodes, NUMA nodes, interleavi=
ng=0A> between nodes...=0A> =0A=0ANode is the NUMA node, We get the numa =
id by calling dev_to_node().=0A=0A> Is there any practical use case and n=
eed behind this?=0A>=0A=0ASome dimm may not be recognized when boot, we w=
ant to find it.=0A=0AThe '/sys/devices/system/node/node0/meminfo' would s=
how the memory on=0Anode0.=0A=0AIf we have '/sys/devices/system/node/node=
0/mc0', by comparing the number=0Aof dimm and MemTotal in meminfo. It is =
easy to know that the dimm didn't =0Arecognized whether it belonged to th=
is NUMA node or not.=0A=0A =0A> --=0A> Regards/Gruss,=0A> Boris.=0A> =0A>=
 https://people.kernel.org/tglx/notes-about-netiquette
