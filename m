Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D4F1256BC
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2019 23:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfLRWbR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Dec 2019 17:31:17 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:53391 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfLRWbR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Dec 2019 17:31:17 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 239BD1E0B;
        Wed, 18 Dec 2019 17:31:14 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 18 Dec 2019 17:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=Lzyvf/oAweCjZ5qIV56uJI0Ozerep15
        7X4x8VBFaL2w=; b=fgkh+Wd1faRZ80tV79SqEgiqfO47hlCbRGjvMXW/tF7jki9
        WynI1IF7nJLBpyfFNBrs5kB/iD9B1kZ4Zct/KVqlmhAjbOmezDRIj68BgFn9cKrO
        6zVbHOITS5uYfxQbYW64M2VcaKodkAdmf+8kBkA/mm8cEojiNaJ0rBJMWyM5iOrA
        cQ32L48NZETL5UM0mGXuk5qtld06H6KvTLd/QRZEBWK2uUjG/fMq3afcmeP2Ih1F
        6wwQweBoXijypJ+cC4RH5UgCYG4mCFKK+XeG8mS/OMQRoqwSejkVoevxOJ5J8BBd
        yxNpuEGrb4n1BnHbYP8kBZFKKwJAzpuZRUsVhCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Lzyvf/
        oAweCjZ5qIV56uJI0Ozerep157X4x8VBFaL2w=; b=Ag20xibjqHXMkA9a8aMYoI
        ymKmoMLALOwuT3RPU4NmvqWfucAiAItau1LrU6oqlFu5Yx7AnxaOgXYQMK83j5BD
        Xi1ou27OAwT6EHUZYDWbaBwW7nB4IMXpjyYFK81CtGRS9SggF7BweRFMTXZKLofv
        kCqCYoxzUG30G17iZ0lyC3lAIjCUrYlFLS1vUlnyAANTVhmi+s5Alwy696plDaFd
        E0C+9w7DORjvdmRgIErOl5NlfrXWfyzy0F1IucCKgW3Xu4ij9y72lfbNNZK4AuLs
        upfQ+Wh+GcQNPNLmDWGZvMamMOwyk6GpA6Q+MIAHaYL0ghXKPB5vJHWjuphfW6rQ
        ==
X-ME-Sender: <xms:rqj6XfEXRl9AX1MZQR9DICsNKazBcDuTVlw-GrXsNQfmXGJubEBsiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtledgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:rqj6Xfa4-8pcRXygko6cwYT0kJmFx7aETOpInZFh_-vM2nBcvhtrvA>
    <xmx:rqj6XbycQMjEhwpDN8jUPmY8f2_5AiuUjH9h8oL23BayYpp2vVsdAA>
    <xmx:rqj6XZQbpq4QZV3aBoG8HOYeycBGUTb1k2zNIIiwFumDcPWv7qe7GQ>
    <xmx:sqj6XXWAf5MO83LJorjEsG5NKdLUN_wd55TeemMVrtKwttyCxseetw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CAC89E00A3; Wed, 18 Dec 2019 17:31:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-694-gd5bab98-fmstable-20191218v1
Mime-Version: 1.0
Message-Id: <524f6f1c-c32d-498b-b835-ae01c338a7e2@www.fastmail.com>
In-Reply-To: <1576648806-1114-1-git-send-email-vulab@iscas.ac.cn>
References: <1576648806-1114-1-git-send-email-vulab@iscas.ac.cn>
Date:   Thu, 19 Dec 2019 09:02:53 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Xu Wang" <vulab@iscas.ac.cn>,
        "Stefan M Schaeckeler" <sschaeck@cisco.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>, tony.luck@intel.com,
        "James Morse" <james.morse@arm.com>, rrichter@marvell.com,
        "Joel Stanley" <joel@jms.id.au>
Cc:     linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: aspeed: Remove unneeded semicolon
Content-Type: text/plain
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On Wed, 18 Dec 2019, at 16:30, Xu Wang wrote:
> Remove unneeded semicolon reported by coccinelle.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
