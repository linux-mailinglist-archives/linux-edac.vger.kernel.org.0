Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89831400B7B
	for <lists+linux-edac@lfdr.de>; Sat,  4 Sep 2021 15:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhIDNYQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 4 Sep 2021 09:24:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:41841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230297AbhIDNYQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 4 Sep 2021 09:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630761779;
        bh=VedANFIqdoIjEowtEWOZv/ASCI66wxx8Mg47+8sNjBE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KGRV4H0rUFaNpYk30tnCxpFQBIMZsXQRwqWykxbSnBD1qN2GhR5Ta99iwq/NZyBiQ
         QSiuR+R1jpvHgoUX6mv22UAiIuQNKio8kIdZ5t0jWWShfmwu3W4dIpLPYGqyBXgXqU
         zb4skP+/Csih/O2Nlz10uU0XlGNbr3lFJNzS3qUo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiPl-1mYF5T3bzh-00U0Aj; Sat, 04
 Sep 2021 15:22:59 +0200
Date:   Sat, 4 Sep 2021 15:22:44 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Len Baker <len.baker@gmx.com>, Joe Perches <joe@perches.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] EDAC/mc: Prefer strscpy or scnprintf over strcpy
Message-ID: <20210904132244.GA2384@titan>
References: <20210903150539.7282-1-len.baker@gmx.com>
 <3a035a3ec4571a622ce640e042f9a119@perches.com>
 <20210904094451.GA2998@titan>
 <YTNaOsF3cRpL7065@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTNaOsF3cRpL7065@zn.tnic>
X-Provags-ID: V03:K1:01/cutQ6WDHs06bO6yQe43QhF9ZJYQd4XTLYWuJ5jvZM09VoDut
 y9NBU3I1Cv8oxk8tZITw/Rb2wptgQQ6Y57HhPuhEJ5syUOmI63Djkf4kf+ErgacjINoSvz8
 9HtHWTqeeUa61gOek37pjXBJOAPgJnKFEGcRz1R88SCQ2379R0oAYGLBy9EF5Pk2Icarcg6
 ETvXR66cQz3CInpw4yF7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MDv4+8Eu+1c=:3eglAEAFlOmd9f4/pip2Pg
 Nbll9pQ6VVQBu/4pdJ6kdsLTUecOq2sn+f3V44l37diWcR9UR0KV6zSnORM599u3GozJx0teD
 qQ9b4zZxD/qHLDlk1hZguRKSN9/UrjFGtxva6qmYLN9VCTIhILmXVPEvYRjMx4oZqwSdAoYkM
 zOtl6hB2gXtLGP2NsyQ5Qxcgz4B17sUKKdJunrnDO5bKEI2cvAgCKIeQPtT7fPGKA5ZeCSDdj
 lt/A/ugYsE/cAnXNK+3ikKXXCZliqDoRXaNmsih3S/6N+CWnSwhZ/IW2fxPn6lnKmLQhLT2cf
 s2o/V5DQhgZpkLwDH1khQ2+QSgjYSV2o32R5OU8CmnslpYNJOfPUQd2ZiFib9AGpyxOgYhCOp
 krqcaNGA54hkXSWJxKYSfCzMiEEBw1a3tyfuWwj2vr5ukCjobBM6XTyeWZ3sWlP9aEs7+3Klv
 gOI2vCdL/wlsSTrcpRjdDoaOEh2R4cRqDRcn1sbMj5CweLb2WzqkTEfQ7WibtY2MFL7nOvh4g
 HYRH6aiadekvQ3BeWs1OsuEjilPCM8LCbt+vZLpPOxPrdjRStBdU6NqglEMYxplSRFGE35Xge
 mLqJT1xcatTZS42KZFuWyq5Rf9hAnvbGvm2MIuYKhff+coZBh/RaK00ta9OTEp365dpbvQe4m
 n7qXwWvXxI8J/9Pfw/PCQjnU4dsCtdkeL0RwH9P85QUpTYT4HKGyELXr1efARjIWpHkAjzBA/
 q/BW2mNW5PYzwB2DlRprj3G3FiULEDdLaPz0ZdW5lhAqnEPB89MATRd/qSoUP8SZ59kPnm5Pp
 ISjgYZcvnMglhLMhcf5m+nNG1gftWU1bID1E5GCbPe+dsh9XkozS9WJCqSoM32ZDMmBVXLuVs
 JqkTbOoYXYdDZT1utwRk+nwnYWxea3qtqm5t5fu1JhY6mXZw6XLxd3mrt2PDitQpqeW5o0GKd
 W3nnwYpIr+G5K9EBm911GPjNyIKg60CFp1xRdgde8QcZDT1k7syUYwOLSuQeose23ycfqHw9f
 loHcfpopwdbd+nwlY/9rhC+du8qxfBy+ooToaO1s132rfsdfOtk/wbvFKnBLUe9kSaAxHV7H+
 Fk4DYAjDMgH4eeXCP8UE0XcZma84sbO1K2oJghXmG37jHfmj8TGXt3uLA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On Sat, Sep 04, 2021 at 01:36:26PM +0200, Borislav Petkov wrote:
> On Sat, Sep 04, 2021 at 01:23:03PM +0200, Len Baker wrote:
> > I can remove the macro and add a comment with some explanation.
>
> No, please leave the macro.

Ok, so I leave the patch as is.

Thanks,
Len
