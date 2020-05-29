Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8D1E789B
	for <lists+linux-edac@lfdr.de>; Fri, 29 May 2020 10:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgE2Ip4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 May 2020 04:45:56 -0400
Received: from mout.web.de ([217.72.192.78]:34581 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgE2Ipz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 29 May 2020 04:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590741917;
        bh=jUErHUL9WbH7n+OLrZtE6OPz7mknY+Wrj1q3ojd8XT8=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=aKg6gIDvZJgHoEZFeeGfq/BpvQqEEK/SNnvw42NE/PV0Q3ofAFVY/m+4LjrDPsspa
         CVGks6GNE4HCtKaqL4iJ4xTW9x0IRLLFn6Xyzg0fgn9yEMS4s1I9dxvK9IQqRSWCBG
         64/Db4QsfMJzTQOJng7XaGj1u19bw3Q8gUwHqoaI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.165.0]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6E6g-1ilwXv0ow6-00yDAt; Fri, 29
 May 2020 10:45:17 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Doug Thompson <dougthompson@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>, Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] edac: Fix reference count leak in
 edac_device_register_sysfs_main_kobj()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Qiushi Wu <wu000273@umn.edu>, linux-edac@vger.kernel.org
Message-ID: <77d6b960-aedc-c7ce-5df9-f3653bfd500a@web.de>
Date:   Fri, 29 May 2020 10:45:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fjfd3QTMoQRl1syGMV/ivxiy7MFQQq1LVLfjs3qIi8BVXPcGsP9
 H1CHMiO1Wvl01kh6MvpgY/UPJE24o9/0CWarVH6cw2PFtxSa1H/OgYY/d70O60NoITDCCv3
 SAmZnIjoGu7Fts9PaqTzfWLI++BmHPUYxpCHl324qIYktCDCAOu2EoeHKQrsvwt3xw0xSpQ
 h/vGcmn8AsCF2OSOHUXPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x2jX0IiS1Ac=:NCaFrdmx8YZEHcKdUGCaOj
 IkOb7ZH3FKCErm5fWg/MJHkWffq7Sct7YXjYFg3pGyrlaqv3kIWN9hZIzMN0k8lBFRqtKUwom
 f9qx/fO1lnxGU1cGHuVdvNM9Xoy15kJvfowsTXIwNXHuksRY8ReGaZW5GDFpTOPkILUqn2j1I
 eKF+RNlDj1QkN2ClVxLF5tRQZ7zEuuHNE61vQo+qTJDxk2jSrurEcn85AKYyRr74zJRzyVXdV
 CkuP3w0ZbZ77JELJ1UUZpLoqtwFErdWcrS4OGxi6SMM5JNNjFfZ9cIucZW7T8jjmAeR6v1QvF
 V08ErJiXF9SaV2Wb2UuLLmBqUZM9MACZpgncFo+1kv5rynjDCwMGOlwr0WOTZKEyntUinUk2V
 hOGqJqes9kMCRHFsSWFE0K7zWqaEfl3HeY7dmLKneJsUaXB4SoBn7xPd9/XbAbrxajNvTdryS
 A7EFXtVFBBPDs6pPcftLVF7Nk+jBvSNrccD9iFH9hUZR7T1MK44/WFrBvKYl6XYB0XVVx9d4F
 19SVOIPQ9Lgtn8y+a5/QkRK+tYSSwVMP0m8Us6COrSvjRApG4W5pfdJ4x+mxZZ4DCjocsdehc
 OvQJZMf1sE9APRkNrD0HvgZsRD+//SUZSNfVV53msQLOzelX/W0vxrgNyM2c7pt54GURbLUSS
 2rVePVyx0ZQLC8l/iNAgW93GK6ApK7uFCQmJrQflBT8BTqZu5VtcfL4GuFiOwB0RpkjqVS7aZ
 B6xC9G1aQYJ7G/SyexHUzTxEjeydMsADrvwZeDtLz0jSK5QSICjEiGTysCDTPc2sFf0Zw9pFF
 uUIvmrk76WBk6Ny+nUAmo4hm7ftJZgeWlJYS+XFxGbOjdcYFQvi1zSnmhgCC8SIFSph40A+Bp
 08nBPIG0dPKPjljaJ+TwKiF9wEOtV1A9poud1bi+NeUm6Jf0fu4/nj3PjXho7Yd4uDoO2ZLa7
 /Fe1ZtVcRzM3+tS/CH0lPrv/UEFufkPR5lCI8ari42MtXKCYmjaUFTPQeRonUBef2cj4Ko8kL
 eag+KpUZoa4AetCUg4mwubFjOqKuT1qRwO8FtFFpL+UwcJ65xwG0VFrJK8mbZoHdjElTL95G7
 69iwgpYcJL/ENneOKMpdcySAPqXp9/nGH5scc3q9QNbZ4cYp/Iuj4cp9MGAOrtqWtwSNqDFHm
 hdErxSEXecr1TCIEigh0BPf3JQFqgQIC6jFNfNwAtPIXQZNpJNGmUsrVK3ubGlDrZALTinSk+
 Ik4+Q1Y36ow4FdCpv
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> object_init_and_add() should be handled when it return an error,
> because kobject_init_and_add() takes reference even when it fails.

I find this wording approach improvable.


> Previous commit "b8eb718348b8" fixed a similar problem.

Would you like to indicate with such information (according to
the topic =E2=80=9Cnet-sysfs: Fix reference count leak in rx|netdev_queue_=
add_kobject=E2=80=9D)
that your issue was detected also with the help of the kernel fuzzing
tool =E2=80=9Csyzkaller=E2=80=9D?


How do you think about to add an imperative wording to the change descript=
ion?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Db0c3ba31be3e45a130e13b278c=
f3b90f69bda6f6#n151


Will it be helpful to combine this update step together with
=E2=80=9Cedac: Fix reference count leak in edac_pci_main_kobj_setup=E2=80=
=9D
into a small patch series?
https://lore.kernel.org/lkml/20200528202238.18078-1-wu000273@umn.edu/
https://lore.kernel.org/patchwork/patch/1249351/

Regards,
Markus
