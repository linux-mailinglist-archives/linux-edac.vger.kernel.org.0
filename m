Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB1DD1D12
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 01:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfJIXy5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Oct 2019 19:54:57 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:32970 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731103AbfJIXy5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Oct 2019 19:54:57 -0400
Received: by mail-io1-f44.google.com with SMTP id z19so9668515ior.0
        for <linux-edac@vger.kernel.org>; Wed, 09 Oct 2019 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VsFnm8XaI7QXmr5VDdmna3BqJxVjha1I8fPCcDzsiWM=;
        b=epjOkVExnNB8/LCawWiPCUAagejF3IE/8GKqoQYMrHYh5O9cLqfmcIcusOogGKDEpa
         ETp2FpGTymlkpJvGm4RdSXVNmpxASY6yiZEcIc4En8gxy0HEwE0SuDMnvj2C/MmdmtLl
         9SAmIL8fTgiEdYtmfHxvqDsoaO9N+koFVbN0tEhLBfFyI6I6itzNd8HplX8Cnkfm0B+0
         WBv49GaiXwntvyWniiPNMMT98DcglDZmHyki6XsxqN76bxfC5aDgUaBDkjPCLbkUkCJU
         MKmMY0THwT+DhTs9Ryz4QUPODq7pcA3opu8BbwV5C1GfbzYcypzb5Jl9fZc/YZn2YjeS
         HPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VsFnm8XaI7QXmr5VDdmna3BqJxVjha1I8fPCcDzsiWM=;
        b=hyQaeaZa0SqHJOPcCphKNjKf9VIFtKaRmNtfSQt0otZhzYkJt7vGjgurk8EtyS9QoI
         AMap4VlIofBoN40xpwKRRhFgsQtlwDfR4ZNWr6TQ2eL1cHNQX4hfrpBDg8hR6skatWSy
         /cXAP1JRmiu92EvvQ5Dd8FySdmeMSut2qTvnMgyZqWOKpRQN6JN9ZxlmRXOLKR595Z++
         ONDs7V+dMdvWK86dfbgQ4/9v4m99/LZx+4eoQbgKJIjmIlFPBQDeEZWQw2A/ZoL6iG05
         cPKhCUO0WXPM7dAMNHx9ct53uxoF1ZWPQ3e7cRpLkbg4Y4u6uvMmVuSuAmvDJFPX5Ucm
         m82A==
X-Gm-Message-State: APjAAAUiQ/k423HLElbu9+58K2wyb8CqaJmByvaLnIwDMWpme5CkiRoc
        +01mmSCmqvwev2vUYmSQNBMcIqTVY0CJ2okFDHA=
X-Google-Smtp-Source: APXvYqxPgm8NzsHPh+vLkYUrxrrV4Hqa1huo489/D77lbpLZPx6yGnZ70rloYBLFqG0H+HOKrDwa+yKUCzuW1dPnf1I=
X-Received: by 2002:a6b:6418:: with SMTP id t24mr624380iog.185.1570665296257;
 Wed, 09 Oct 2019 16:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAEVokG7TeAbmkhaxiTpsxhv1pQzqRpU=mR8gVjixb5kXo3s2Eg@mail.gmail.com>
 <20190924092644.GC19317@zn.tnic> <CAEVokG7UmudOALmeTBq2NgFSiZyGq_6b58nHt2UUHAM2Mzbw+Q@mail.gmail.com>
 <20191007071502.GA24289@zn.tnic> <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
 <20191008115041.GD14765@zn.tnic> <678ba7d1-cf3d-4101-1819-29b291cf236d@amd.com>
 <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
 <20191009103041.GC10395@zn.tnic> <724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com>
In-Reply-To: <724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com>
From:   Jeff God <jfgaudreault@gmail.com>
Date:   Wed, 9 Oct 2019 19:54:45 -0400
Message-ID: <CAEVokG4T5q8PBmf4=vLjPWQjzL_Xwu6yF81=mLjkpoJSoCggkw@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 9 Oct 2019 at 16:31, Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
>
> Ah yes, sorry I forgot to mention that you will need to disable Platform First
> Error Handling. This can be done in the BIOS. It's usually under something
> like:
>
> AMD CBS -> "Core" Common Options -> Platform First Error Handling
>
> This feature will prevent writes to the MCA registers.
>
> Please let me know if this works or not for you. I'll need to do some more
> debug if it doesn't work.
>
On my side I don't have that setting in my bios under AMD CBS.
Would this setting also prevent error reporting at the OS level or is
it just related to the injection?
The only thing I could find in my bios about ecc is Auto (default),
Enable, Disable

Jean-Frederic
