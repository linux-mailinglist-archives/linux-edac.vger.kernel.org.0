Return-Path: <linux-edac+bounces-166-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAD38010B4
	for <lists+linux-edac@lfdr.de>; Fri,  1 Dec 2023 18:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE131F20F91
	for <lists+linux-edac@lfdr.de>; Fri,  1 Dec 2023 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D14D59B;
	Fri,  1 Dec 2023 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noFyjEJv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807AC103
	for <linux-edac@vger.kernel.org>; Fri,  1 Dec 2023 09:04:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db512266d27so944456276.3
        for <linux-edac@vger.kernel.org>; Fri, 01 Dec 2023 09:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701450292; x=1702055092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbmCSI5K+Qp+wla/FUZNboDkH6vkaCc9VLdnolKakNc=;
        b=noFyjEJvzmVlRRLojlSuZXrCrc4Yzgu+xDbrsD/cVPN7F03GE6eMPPp2H+YzBE1dwq
         R+pO5gCtR8CSLpl9WZGog5pt0o+51OULhEANXl1ORn/9U3Ib3uS4kVhhHjjw+QRjnlQb
         iTobRKJhTmdnsnzXNvxcmnEVfBYI6g+xvpIe+Tn2XX1MxywHY4ZVtrqQmbs1EYx5S3XX
         25t/M24RG29rgjcLg+dXhKtukBHzNIg4uz4B7MlaSLZ9EvMhB+pajfNMychzXyjUsg3/
         fjgGd5Uu1js1Yj+iyPEA6TCAsGuHPdGgKVVNnpCKBgBMYuBiIll9KqM5lW05R0huS1IL
         COgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701450292; x=1702055092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbmCSI5K+Qp+wla/FUZNboDkH6vkaCc9VLdnolKakNc=;
        b=vMVCL70PdM35YDRFcK2NM8yn+7hyw2kxF45P6Pn1Nlay50PmR1AX59ra6pisx2RjP9
         CsiBQq7ZAUlR5V1eXUICb6b9yI5vrCU7ZtP34l38NXAFsBS6HG/QypymZTkWJGb+O44v
         fH8Poxxl61hIVK5hKzfjg+OID+GpSSexh7poNax5yuPxe7xl9b9ZbHrroWn62isYwIER
         3nxSKDdZo4vx8lzPfnjUuAS2rTNEH2/vORfeeggbC6mUuR42oPHoqlCQJurtky5ykQ4q
         sNLDxa6o/alCIbBr57WFI7yFYCq+emKn0FGxcg2hX7Qf2iNqKoDjRzsrUIv0vGnZlqQY
         c3Hw==
X-Gm-Message-State: AOJu0YzWdOxjr99b3aConoCsHXB+NMOomslY2qcSDMi+VXOD9GGBrg/s
	4sS7ps3c7ZRt8DVjQc1QWQ05Zb7zCsY=
X-Google-Smtp-Source: AGHT+IEa3BfWc92nmp+AtwxI8x7qhWNabfXhEQhxlZ9l+TV5/mqVnAJW8EBvcmW340xIWHXBNkD9Ysp+RPg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6e83:0:b0:d9a:e3d9:99bd with SMTP id
 j125-20020a256e83000000b00d9ae3d999bdmr780648ybc.5.1701450292702; Fri, 01 Dec
 2023 09:04:52 -0800 (PST)
Date: Fri, 1 Dec 2023 09:04:51 -0800
In-Reply-To: <20231123003513.24292-3-ankita@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231123003513.24292-1-ankita@nvidia.com> <20231123003513.24292-3-ankita@nvidia.com>
Message-ID: <ZWoSM_0xLJQo8De5@google.com>
Subject: Re: [PATCH v2 2/4] mm: Add poison error check in fixup_user_fault()
 for mapped pfn
From: Sean Christopherson <seanjc@google.com>
To: ankita@nvidia.com
Cc: jgg@nvidia.com, alex.williamson@redhat.com, naoya.horiguchi@nec.com, 
	akpm@linux-foundation.org, tony.luck@intel.com, bp@alien8.de, 
	linmiaohe@huawei.com, rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, 
	shiju.jose@huawei.com, bhelgaas@google.com, pabeni@redhat.com, 
	yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com, 
	kevin.tian@intel.com, aniketa@nvidia.com, cjia@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com, 
	acurrid@nvidia.com, apopple@nvidia.com, anuaggarwal@nvidia.com, 
	jhubbard@nvidia.com, danw@nvidia.com, mochs@nvidia.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 23, 2023, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> The fixup_user_fault() currently does not expect a VM_FAULT_HWPOISON
> and hence does not check for it while calling vm_fault_to_errno(). Since
> we now have a new code path which can trigger such case, change
> fixup_user_fault to look for VM_FAULT_HWPOISON.
> 
> Also make hva_to_pfn_remapped check for -EHWPOISON and communicate the
> poison fault up to the user_mem_abort().

I would much prefer the KVM change be split out to its own patch, I see no
reason why it needs to be bundled with the fixup_user_fault() change.  KVM will
set pfn to KVM_PFN_ERR_FAULT before and after the fixup_user_fault() change.

> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  mm/gup.c            | 2 +-
>  virt/kvm/kvm_main.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 231711efa390..b78af20a0f52 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1414,7 +1414,7 @@ int fixup_user_fault(struct mm_struct *mm,
>  	}
>  
>  	if (ret & VM_FAULT_ERROR) {
> -		int err = vm_fault_to_errno(ret, 0);
> +		int err = vm_fault_to_errno(ret, FOLL_HWPOISON);
>  
>  		if (err)
>  			return err;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 486800a7024b..2ff067f21a7c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2731,6 +2731,12 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
>  		r = hva_to_pfn_remapped(vma, addr, write_fault, writable, &pfn);
>  		if (r == -EAGAIN)
>  			goto retry;
> +
> +		if (r == -EHWPOISON) {
> +			pfn = KVM_PFN_ERR_HWPOISON;
> +			goto exit;
> +		}
> +
>  		if (r < 0)
>  			pfn = KVM_PFN_ERR_FAULT;

I vote for

		if (r == -EHWPOISON)
			pfn = KVM_PFN_ERR_HWPOISON;
		else if (r < 0)
			pfn = KVM_PFN_ERR_FAULT;

or even opportunstically fix the < 0 weirdness:

		if (r == -EHWPOISON)
			pfn = KVM_PFN_ERR_HWPOISON;
		else if (r)
			pfn = KVM_PFN_ERR_FAULT;

It's rather confusing to see a goto in one error path but an effective fallthrough
in a different error path, i.e. gives the impression that KVM_PFN_ERR_HWPOISON
has some special behavior that doesn't apply to KVM_PFN_ERR_FAULT.

