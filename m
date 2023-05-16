Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27024704BD5
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 13:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjEPLJE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 07:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjEPLIw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 07:08:52 -0400
Received: from out-44.mta0.migadu.com (out-44.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC5A55BE
        for <linux-edac@vger.kernel.org>; Tue, 16 May 2023 04:08:16 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684235232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HqcG8Pa5FDcqYhq4OhpM7Vdusuun/XixcvI4+f9r/hI=;
        b=WO+pieyPfbb8Ff15hg3msV3GPOHIdNp59R6nFfvovsEsj8GO7BR0AlFj56zVnnskEfUnuQ
        8YZ/I0aVgjNurZ/4ypQter0TDPc7o3e55j9td9djQWkmfVJq9De/PO6+Afg9vzmWKSTvXt
        RNKYuRe1nxCZG1LzkbfyKvh+Up9NfDY=
Date:   Tue, 16 May 2023 11:07:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <e930d9a3efd6d99d2badc7bdff713afd@linux.dev>
Subject: Re: [PATCH] EDAC: Expose node link in sysfs if CONFIG_NUMA
To:     "Borislav Petkov" <bp@alien8.de>
Cc:     tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20230516103403.GBZGNcG7Q1sdtUpcHW@fat_crate.local>
References: <20230516103403.GBZGNcG7Q1sdtUpcHW@fat_crate.local>
 <20230516080748.3155788-1-yajun.deng@linux.dev>
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

May 16, 2023 6:34 PM, "Borislav Petkov" <bp@alien8.de> wrote:=0A=0A> On T=
ue, May 16, 2023 at 04:07:48PM +0800, Yajun Deng wrote:=0A> =0A>> The nod=
e in sysfs already has cpu link and memory link, the memory=0A>> control =
also under a node.=0A>> =0A>> Expose node link to memory control director=
y and expose memory control=0A>> link to node directory if CONFIG_NUMA.=
=0A> =0A> Why?=0A> =0AIt will help users to confirm which MC belongs to w=
hich node if there are multiple=0AMCs. Therefore, we can also know how ma=
ny dimm on each node.=0A=0A>> At the same time, change the type of EDAC f=
rom tristate to boolean=0A>> because it needs node_devices.=0A> =0A> Nope=
.=0A> =0A> --=0A> Regards/Gruss,=0A> Boris.=0A> =0A> https://people.kerne=
l.org/tglx/notes-about-netiquette
